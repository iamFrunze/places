import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/get_place_request_model.dart';

abstract class PlaceInteractor {
  Future<List<PlaceModel>> getPlaces({GetPlaceRequestModel? model});
  Future<PlaceModel> getPlaceDetails(int id);
  Future<List<PlaceModel>> getFavouritesPlaces();
  Future<bool> addToFavourites(PlaceModel place);
  Future<bool> removeFromFavourites(PlaceModel place);
  Future<List<PlaceModel>> getVisitPlaces();
  Future<bool> addToVisitingPlaces(PlaceModel place);
  Future<bool> addNewPlace(PlaceModel place);
}