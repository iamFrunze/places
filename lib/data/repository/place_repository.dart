import 'dart:io';

import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/get_place_request_model.dart';
import 'package:places/data/model/request_model/post_filtered_places_request_model.dart';

abstract class PlaceRepository {
  Future<List<PlaceModel>> postFilteredPlaces(
    PostFilteredPlacesRequestModel model,
  );
  Future<PlaceModel> postPlace(PlaceModel model);
  Future<List<PlaceModel>> getPlace({required GetPlaceRequestModel model});
  Future<PlaceModel> getPlaceId({required String id});
  Future<bool> deletePlace({required String id});
  Future<bool> putPlace(PlaceModel model);
  Future<List<String>> postUploadFile(File file);
  Future<String> getFiles(String filePath);
  Future<String> getClient(String path);
}
