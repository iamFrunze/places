import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/interactors/place_interactor_remote.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/get_place_request_model.dart';

class SightListSettings extends ChangeNotifier {
  final PlaceInteractorRemote _interactor;
  final _favouritePlaces = <PlaceModel>[];
  bool isLoadData = false;

  SightListSettings(this._interactor);

  Stream<List<PlaceModel>> fetchData() async* {
    isLoadData = true;
    _favouritePlaces.clear();
    final places = await _interactor.getPlaces(
      model: const GetPlaceRequestModel(count: 5),
    );
    _favouritePlaces.addAll(await _interactor.getFavouritesPlaces());
    isLoadData = false;

    yield places;
  }

  Future<void> addToFavourite(PlaceModel place) async {
    isLoadData = true;
    if (_favouritePlaces.map((e) => e.id).contains(place.id)) {
      _favouritePlaces.remove(place);
      await _interactor.removeFromFavourites(place);
    } else {
      _favouritePlaces.add(place);
      await _interactor.addToFavourites(place);
    }
    isLoadData = false;
    notifyListeners();
  }

  bool isFavourite(PlaceModel place) =>
      _favouritePlaces.map((e) => e.id).contains(place.id);
}
