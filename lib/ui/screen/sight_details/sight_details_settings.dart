import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place_model.dart';

class SightDetailsSettings extends ChangeNotifier {
  final PlaceInteractor _interactor;

  int get currentIndex => _currentIndex;
  PlaceModel? get place => _place;
  String? get planningDate => _planningDate;
  bool get isFavourite => _isFavourite;

  String? _planningDate;
  PlaceModel? _place;
  int _currentIndex = 0;
  bool _isFavourite = false;

  SightDetailsSettings(this._interactor);

  void onPageChange(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void updatePlanningDateSight(DateTime date) {
    _planningDate = formatDate(
      date,
      [dd, ' ', M, ' ', yy],
      locale: const RussianDateLocale(),
    );
    debugPrint('plan date $planningDate');
    notifyListeners();
  }

  Future<void> fetchPlace(int id) async {
    final place = await _interactor.getPlaceDetails(id);
    _updateData(place);
    notifyListeners();
  }

  Future<void> addToFavourite() async {
    final favouritePlace = _place;
    if (!_isFavourite) {
      if (favouritePlace != null) {
        await _interactor.addToFavourites(favouritePlace);
        _isFavourite = true;
      } else {
        throw Exception('Place not found');
      }
    } else {
      if (favouritePlace != null) {
        await _interactor.removeFromFavourites(favouritePlace);
        _isFavourite = false;
      } else {
        throw Exception('Place not found');
      }
    }
  }

  void _updateData(PlaceModel model) {
    if (_place != model) {
      _currentIndex = 0;
      _place = model;
      _planningDate = null;
      _isFavourite = false;
    }
  }
}
