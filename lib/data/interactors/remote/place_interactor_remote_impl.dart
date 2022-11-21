import 'package:places/data/exceptions/network_exception.dart';
import 'package:places/data/interactors/remote/place_interactor_remote.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/get_place_request_model.dart';
import 'package:places/data/repository/place_repository.dart';

class PlaceInteractorImpl implements PlaceInteractorRemote {
  final PlaceRepository _repository;

  PlaceInteractorImpl(this._repository);

  @override
  Future<bool> addNewPlace(PlaceModel place) async =>
      _repository.putPlace(place);

  @override
  Future<PlaceModel> getPlaceDetails(int id) async {
    try {
      final response = await _repository.getPlaceId(id: '$id');

      return response;
    } on NetworkException catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<PlaceModel>> getPlaces({
    GetPlaceRequestModel? model,
  }) async {
    try {
      final response = await _repository.getPlace(model: model);

      return response;
    } on NetworkException catch (_) {
      rethrow;
    }
  }
}
