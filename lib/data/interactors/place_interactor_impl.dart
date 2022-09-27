import 'package:places/data/interactors/place_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/get_place_request_model.dart';
import 'package:places/data/repository/place_repository.dart';

class PlaceInteractorImpl implements PlaceInteractor {
  final _favouritesPlaces = <PlaceModel>[];
  final _visitingPlaces = <PlaceModel>[];
  final PlaceRepository _repository;

  PlaceInteractorImpl(this._repository);

  @override
  Future<bool> addNewPlace(PlaceModel place) async =>
      _repository.putPlace(place);

  @override
  Future<bool> addToFavourites(PlaceModel place) async {
    _favouritesPlaces.add(place);

    return true;
  }

  @override
  Future<bool> addToVisitingPlaces(PlaceModel place) async {
    _visitingPlaces.add(place);

    return true;
  }

  @override
  Future<List<PlaceModel>> getFavouritesPlaces() async => _favouritesPlaces;

  @override
  Future<PlaceModel> getPlaceDetails(int id) async {
    final response = await _repository.getPlaceId(id: '$id');

    return response;
  }

  @override
  Future<List<PlaceModel>> getPlaces({
    GetPlaceRequestModel? model,
  }) async {
    final response = await _repository.getPlace(model: model);

    return response;
  }

  @override
  Future<List<PlaceModel>> getVisitPlaces() async => _visitingPlaces;

  @override
  Future<bool> removeFromFavourites(PlaceModel place) async {
    _favouritesPlaces.remove(place);

    return true;
  }
}
