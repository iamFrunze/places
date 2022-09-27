import 'package:flutter/material.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/get_place_request_model.dart';

class SightListSettings extends ChangeNotifier {
  final PlaceInteractor _interactor;
  List<PlaceModel> get places => _places ?? [];
  List<PlaceModel>? _places;

  SightListSettings(this._interactor) {
    Future.microtask(_initData);
  }

  Future<void> _initData() async {
    _places = await _interactor.getPlaces(
      model: const GetPlaceRequestModel(count: 5),
    );
    notifyListeners();
  }
}
