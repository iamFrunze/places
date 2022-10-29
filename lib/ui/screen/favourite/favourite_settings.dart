import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/interactors/place_interactor.dart';
import 'package:places/data/model/place_model.dart';

class FavouriteSettings extends ChangeNotifier {
  final PlaceInteractor _interactor;

  List<PlaceModel> get visitingPlaces => _visitingPlaces;

  late List<PlaceModel> _favouritesPlaces;
  late List<PlaceModel> _visitingPlaces;

  FavouriteSettings(this._interactor);

  Future<void> removeFromFavourites(PlaceModel place) async {
    await _interactor.removeFromFavourites(place);
    _favouritesPlaces.remove(place);
    notifyListeners();
  }

  Future<void> removeFromFavouritesAt(int index) async {
    final place = _favouritesPlaces[index];
    await _interactor.removeFromFavourites(place);
    _favouritesPlaces.remove(place);
    notifyListeners();
  }

  Future<void> removeFromVisitingPlaces(PlaceModel place) async {
    _visitingPlaces.remove(place);
    notifyListeners();
  }

  Future<void> removeFromVisitingPlacesAt(int index) async {
    _visitingPlaces.removeAt(index);
    notifyListeners();
  }

  void changePositionVisitingPlace(PlaceModel place, int index) {
    _visitingPlaces.insert(index, place);
    notifyListeners();
  }

  void changePositionFavouritePlace(PlaceModel place, int index) {
    _favouritesPlaces.insert(index, place);
    notifyListeners();
  }

  void onAcceptDragFavouritePlace(PlaceModel place, int index) {
    _favouritesPlaces
      ..remove(place)
      ..insert(index, place);
    notifyListeners();
  }

  void onAcceptDragVisitingPlace(PlaceModel place, int index) {
    _visitingPlaces
      ..remove(place)
      ..insert(index, place);
    notifyListeners();
  }

  Stream<List<PlaceModel>> initFavouritePlaces() async* {
    _favouritesPlaces = await _interactor.getFavouritesPlaces();
    notifyListeners();

    yield _favouritesPlaces;
  }

  Stream<List<PlaceModel>> initVisitingPlaces() async* {
    _visitingPlaces = await _interactor.getVisitPlaces();
    notifyListeners();

    yield _visitingPlaces;
  }
}
