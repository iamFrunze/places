import 'dart:io';

import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/get_place_request_model.dart';

abstract class PlaceInteractorRemote {
  Future<List<PlaceModel>> getPlaces({GetPlaceRequestModel? model});

  Future<PlaceModel> getPlaceDetails(int id);

  Future<bool> addNewPlace(PlaceModel place);

  Future<void> uploadImages(List<File> images);
}
