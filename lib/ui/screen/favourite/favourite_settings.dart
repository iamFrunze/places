import 'package:flutter/material.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/interactors/place_interactor.dart';
import 'package:places/data/model/place_model.dart';

class FavouriteSettings extends ChangeNotifier {
  final PlaceInteractor _interactor;
  ScreenState currentStateFavourite = ScreenState.loading;
  ScreenState currentStateVisited = ScreenState.loading;

  List<PlaceModel> get favouritesPlaces => _favouritesPlaces;

  List<PlaceModel> get visitingPlaces => _visitingPlaces;

  late List<PlaceModel> _favouritesPlaces;
  late List<PlaceModel> _visitingPlaces;

  FavouriteSettings(this._interactor) {
    debugPrint('as');
    Future.microtask(_initVisitingPlaces);
    Future.microtask(_initFavouritePlaces);
  }

  void removeFromFavourites(PlaceModel place) {
    _interactor.removeFromFavourites(place);
    _favouritesPlaces.remove(place);
    if (_favouritesPlaces.isEmpty) {
      currentStateFavourite = ScreenState.empty;
    }
    notifyListeners();
  }

  void removeFromFavouritesAt(int index) {
    final place = _favouritesPlaces[index];
    _interactor.removeFromFavourites(place);
    _favouritesPlaces.remove(place);
    if (_favouritesPlaces.isEmpty) {
      currentStateFavourite = ScreenState.empty;
    }
    notifyListeners();
  }

  void removeFromVisitingPlaces(PlaceModel place) {
    _visitingPlaces.remove(place);
    if (_visitingPlaces.isEmpty) {
      currentStateVisited = ScreenState.empty;
    }
    notifyListeners();
  }

  void removeFromVisitingPlacesAt(int index) {
    _visitingPlaces.removeAt(index);
    if (_visitingPlaces.isEmpty) {
      currentStateVisited = ScreenState.empty;
    }
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

  Future<void> _initFavouritePlaces() async {
    _favouritesPlaces = await _interactor.getFavouritesPlaces();
    currentStateFavourite = ScreenState.success;
    notifyListeners();
  }

  Future<void> _initVisitingPlaces() async {
    _visitingPlaces = await _interactor.getVisitPlaces();
    currentStateVisited = ScreenState.success;
    notifyListeners();
  }
}
