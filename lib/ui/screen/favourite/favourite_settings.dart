import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactors/local/places_interactor_local_impl.dart';
import 'package:places/data/model/place_model.dart';

class FavouriteSettings extends ChangeNotifier {
  final PlacesInteractorLocalImpl _interactorLocal;

  bool isLoadData = false;

  List<PlaceModel> get visitingPlaces => _visitingPlaces;

  List<PlaceModel> get favouritesPlaces => _favouritesPlaces;

  String? get planningDate => _planningDate;
  String? _planningDate;

  List<PlaceModel> _favouritesPlaces = [];
  List<PlaceModel> _visitingPlaces = [];

  FavouriteSettings(this._interactorLocal);

  void updatePlanningDateSight(DateTime date) {
    isLoadData = true;
    _planningDate = formatDate(
      date,
      [dd, ' ', M, ' ', yy],
      locale: const RussianDateLocale(),
    );
    isLoadData = false;
    notifyListeners();
  }

  Future<void> removeFromFavourites(PlaceModel place) async {
    isLoadData = true;
    notifyListeners();
    _favouritesPlaces.remove(place);

    await _interactorLocal.removeFromFavourite(place.id);
    await Future.delayed(const Duration(seconds: 5), () {});

    isLoadData = false;
    notifyListeners();
  }

  Future<void> removeFromVisitingPlaces(PlaceModel place) async {
    isLoadData = true;
    notifyListeners();

    _visitingPlaces.remove(place);
    isLoadData = false;
    notifyListeners();
  }

  void changePositionVisitingPlace(PlaceModel place, int index) {
    isLoadData = true;

    _visitingPlaces.insert(index, place);
    isLoadData = false;
    notifyListeners();
  }

  void changePositionFavouritePlace(PlaceModel place, int index) {
    isLoadData = true;
    _favouritesPlaces.insert(index, place);
    isLoadData = false;
    notifyListeners();
  }

  Future<void> initFavouritePlaces() async {
    isLoadData = true;
    _favouritesPlaces = await _interactorLocal.fetchFavouritePlaces();
    isLoadData = false;
    notifyListeners();
  }

  Future<void> initVisitingPlaces() async {
    isLoadData = true;
    _visitingPlaces = await _interactorLocal.fetchVisitedPlaces();
    isLoadData = false;
    notifyListeners();
  }

  void reorderVisitingItems(int oldIndex, int newIndex) {
    isLoadData = true;
    var insertIndex = newIndex;

    if (oldIndex < newIndex) {
      insertIndex = newIndex - 1;
    }
    final place = _visitingPlaces.removeAt(oldIndex);
    _visitingPlaces.insert(insertIndex, place);

    isLoadData = false;
    notifyListeners();
  }

  void reorderFavoriteItems(int oldIndex, int newIndex) {
    isLoadData = true;
    var insertIndex = newIndex;

    if (oldIndex < newIndex) {
      insertIndex = newIndex - 1;
    }
    final place = _favouritesPlaces.removeAt(oldIndex);
    _favouritesPlaces.insert(insertIndex, place);

    isLoadData = false;
    notifyListeners();
  }
}
