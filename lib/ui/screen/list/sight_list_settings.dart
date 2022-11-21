import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/interactors/local/places_interactor_local_impl.dart';
import 'package:places/data/interactors/remote/place_interactor_remote.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/get_place_request_model.dart';

class SightListSettings extends ChangeNotifier {
  final PlaceInteractorRemote _interactor;
  final PlacesInteractorLocalImpl _interactorLocal;
  final _favouritePlaces = <PlaceModel>[];
  bool isLoadData = false;

  SightListSettings(this._interactor, this._interactorLocal);

  Stream<List<PlaceModel>> fetchData() async* {
    isLoadData = true;
    _favouritePlaces.clear();
    final places = await _interactor.getPlaces(
      model: const GetPlaceRequestModel(count: 5),
    );
    _favouritePlaces.addAll(await _interactorLocal.fetchFavouritePlaces());
    isLoadData = false;

    yield places;
  }

  Future<void> addToFavourite(PlaceModel place) async {
    isLoadData = true;
    if (_favouritePlaces.map((e) => e.id).contains(place.id)) {
      _favouritePlaces.remove(place);
      await _interactorLocal.removeFromFavourite(place.id);
    } else {
      _favouritePlaces.add(place);
      await _interactorLocal.addToFavourite(place);
    }
    isLoadData = false;
    notifyListeners();
  }

  bool isFavourite(PlaceModel place) =>
      _favouritePlaces.map((e) => e.id).contains(place.id);
}
