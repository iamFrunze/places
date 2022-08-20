import 'package:flutter/material.dart';
import 'package:places/app_settings.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/category_model.dart';
import 'package:places/data/repository/sights_repository.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/mocks.dart';
import 'package:places/utils/distance_calc.dart';

class FilterSettings extends ChangeNotifier {
  final SightRepository repository;
  final _booleanListOfCategories = List.generate(6, (index) => false);
  final _selectedCategories = AppSettings.categories;

  ScreenState currentState = ScreenState.loading;

  int get countNearSights => _countNearSights;

  RangeValues get rangeValue => _rangeValue;

  List<CategoryModel> get selectedCategories => _selectedCategories;

  int _countNearSights = 0;

  var _rangeValue = AppSettings.range;

  late List<SightModel> _sights;

  FilterSettings({
    required this.repository,
  });

  Future initData() async {
    final callback = repository.fetchSights();
    if (callback != null) {
      if (callback.isNotEmpty) {
        _sights = callback;
        _countNearSights = callback.where(_isNear).toList().length;
      } else {
        currentState = ScreenState.empty;
      }
    } else {
      currentState = ScreenState.error;
    }
  }

  void selectSight({
    required int index,
    required String type,
    required bool value,
  }) {
    _selectedCategories[index].value = value;
    _booleanListOfCategories[index] = value;
    _sights
        .where((element) => element.type == type)
        .map((e) => e.isSelect = value)
        .toList();

    final selectedSights =
        _sights.where((element) => element.isSelect).toList();

    _fetchNearSights(selectedSights: selectedSights);
  }

  void changeArea({
    required double start,
    required double end,
  }) {
    _rangeValue = RangeValues(start, end);
    final selectedSights =
        _sights.where((element) => element.isSelect).toList();
    _fetchNearSights(selectedSights: selectedSights);
  }

  void clearData() {
    _selectedCategories.map((e) => e.value = false).toList();
    _rangeValue = AppSettings.range;
    _fetchNearSights(selectedSights: _sights);
  }

  List<SightModel> _fetchNearSights({
    required List<SightModel> selectedSights,
  }) {
    final mapSights = <SightModel>[];

    if (_booleanListOfCategories.contains(true)) {
      mapSights.addAll(selectedSights);
    } else {
      mapSights.addAll(_sights);
    }

    final nearSights = mapSights.where(_isNear).toList();

    _countNearSights = nearSights.length;
    notifyListeners();

    return mapSights;
  }

  bool _isNear(SightModel sight) {
    final area = (_rangeValue.end - _rangeValue.start) * 1000;

    final dist = distanceBetween(
      mockLat,
      mockLot,
      sight.lat,
      sight.lon,
    );

    return dist < area;
  }
}
