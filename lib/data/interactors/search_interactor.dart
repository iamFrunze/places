import 'dart:collection';

import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/post_filtered_places_request_model.dart';
import 'package:places/data/repository/place_repository.dart';

class SearchInteractor {
  final PlaceRepository _repository;
  final LinkedHashSet<String> _history = LinkedHashSet();

  LinkedHashSet<String> get history => _history;

  SearchInteractor(this._repository);

  Future<List<PlaceModel>> searchPlaces(String name) async {
    final places = await _repository.postFilteredPlaces(
      model: PostFilteredPlacesRequestModel(nameFilter: name),
    );
    _history.add(name);

    return places;
  }

  Future<List<PlaceModel>> filteredPlaces(
    PostFilteredPlacesRequestModel model,
  ) async {
    final places = await _repository.postFilteredPlaces(model: model);

    return places;
  }

  void saveSearchRequest(String request) {
    _history.add(request);
  }

  void clearHistory() {
    _history.clear();
  }

  void removeSearchRequest(String name) {
    _history.remove(name);
  }
}
