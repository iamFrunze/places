import 'package:places/data/interactors/place_interactor.dart';
import 'package:places/data/model/request_model/get_place_request_model.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/mocks.dart';

class MockInteractorImpl extends PlaceInteractor {
  @override
  Future<bool> addNewPlace(PlaceModel place) {
    // TODO: implement addNewPlace
    throw UnimplementedError();
  }

  @override
  Future<bool> addToFavourites(PlaceModel place) {
    // TODO: implement addToFavourites
    throw UnimplementedError();
  }

  @override
  Future<bool> addToVisitingPlaces(PlaceModel place) {
    // TODO: implement addToVisitingPlaces
    throw UnimplementedError();
  }

  @override
  Future<List<PlaceModel>> getFavouritesPlaces() {
    // TODO: implement getFavouritesPlaces
    throw UnimplementedError();
  }

  @override
  Future<PlaceModel> getPlaceDetails(int id) {
    // TODO: implement getPlaceDetails
    throw UnimplementedError();
  }

  @override
  Future<List<PlaceModel>> getPlaces({GetPlaceRequestModel? model}) async =>
      places;

  @override
  Future<List<PlaceModel>> getVisitPlaces() {
    // TODO: implement getVisitPlaces
    throw UnimplementedError();
  }

  @override
  Future<bool> removeFromFavourites(PlaceModel place) {
    // TODO: implement removeFromFavourites
    throw UnimplementedError();
  }
}
