import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:places/data/interactors/local/database.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/post_filtered_places_request_model.dart';
import 'package:places/data/repository/place_repository.dart';

class SearchInteractor {
  final PlaceRepository _repository;
  final Database _db;
  final LinkedHashSet<String> _history = LinkedHashSet();

  LinkedHashSet<String> get history => _history;

  SearchInteractor(this._repository, this._db) {
    fetchHistory();
  }

  Future<List<PlaceModel>> searchPlaces(
    PostFilteredPlacesRequestModel model,
  ) async {
    final places = await _repository.postFilteredPlaces(model: model);

    return places;
  }

  Future<List<PlaceModel>> filteredPlaces(
    PostFilteredPlacesRequestModel model,
  ) async {
    final places = await _repository.postFilteredPlaces(model: model);

    return places;
  }

  Future<void> saveSearchRequest(String request) async {
    _history.add(request);
    await _db
        .into(_db.searchItems)
        .insert(SearchItemsCompanion.insert(category: request));
  }

  Future<void> clearHistory() async {
    _history.clear();
    await _db.delete(_db.searchItems).go();
  }

  Future<LinkedHashSet<String>> removeSearchRequest(String name) async {
    _history.remove(name);
    final id = (await _db.select(_db.searchItems).get())
        .where((element) => element.category == name)
        .first
        .id;
    await (_db.delete(_db.searchItems)..where((tbl) => tbl.id.equals(id))).go();

    return _history;
  }

  Future<void> fetchHistory() async {
    final places =
        await _db.select(_db.searchItems).map((place) => place.category).get();
    _history.addAll(places);
    debugPrint('places saved $_history');
  }
}
