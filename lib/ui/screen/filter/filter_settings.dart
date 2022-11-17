import 'package:flutter/material.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/interactors/place_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/repository/local/shared_preferences/local_sp_impl.dart';
import 'package:places/mocks.dart';
import 'package:places/settings/constants.dart';
import 'package:places/utils/distance_calc.dart';

class FilterSettings extends ChangeNotifier {
  final categories = Constants.categories;

  final PlaceInteractor _interactor;
  final LocalSPImpl _prefs;

  ScreenState currentState = ScreenState.loading;
  RangeValues rangeValue = Constants.rangeValue;

  int get countNearSights => _countNearSights;
  int _countNearSights = 0;

  late List<PlaceModel> _places;

  FilterSettings(this._interactor, this._prefs) {
    Future<void>.microtask(_initData);

    notifyListeners();
  }

  void selectSight({
    required String type,
    required bool value,
  }) {
    categories.firstWhere((element) => element.type == type).value = value;
    _fetchNearSights();
  }

  void changeArea({
    required double start,
    required double end,
  }) {
    rangeValue = RangeValues(start, end);
    _fetchNearSights();
  }

  void clearData() {
    categories.map((e) => e.value = false).toList();
    rangeValue = Constants.rangeValue;
    _fetchNearSights();
  }

  void _fetchNearSights() {
    final nearPlaces = _places.where(_isNear).where(_isSelected).toList();
    _countNearSights = nearPlaces.length;
    _prefs
      ..saveCategories(categories
          .where((element) => element.value)
          .map((e) => e.type)
          .toList())
      ..saveDistance(rangeValue);
    notifyListeners();
  }

  bool _isNear(PlaceModel sight) {
    final area = (rangeValue.end - rangeValue.start) * 1000;

    final dist = distanceBetween(
      mockLat,
      mockLot,
      sight.lat,
      sight.lng,
    );

    return dist < area;
  }

  bool _isSelected(PlaceModel place) {
    final isSelected = categories
        .where((element) => element.value)
        .map((e) => e.type)
        .toList();
    if (isSelected.isEmpty) return true;

    return isSelected.contains(place.placeType);
  }

  Future<void> _initData() async {
    _places = await _interactor.getPlaces();
    _countNearSights = _places.where(_isNear).toList().length;

    currentState = _places.isNotEmpty ? ScreenState.success : ScreenState.empty;

    notifyListeners();
  }
}
