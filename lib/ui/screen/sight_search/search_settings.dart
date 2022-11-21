import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/exceptions/network_exception.dart';
import 'package:places/data/interactors/search_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/post_filtered_places_request_model.dart';
import 'package:places/data/repository/local/shared_preferences/local_sp_impl.dart';

class SearchSettings extends ChangeNotifier {
  final searchController = TextEditingController();
  final foundSights = <PlaceModel>[];
  final SearchInteractor _interactor;
  final LocalSPImpl _prefs;

  bool initializedSights = false;
  ScreenState currentState = ScreenState.empty;

  LinkedHashSet<String> get historySights => _historySights;

  late LinkedHashSet<String> _historySights;

  SearchSettings(this._interactor, this._prefs) {
    Future.microtask(_fetchHistorySight);
  }

  Future fetchSight({
    String text = '',
  }) async {
    currentState = ScreenState.loading;
    notifyListeners();
    if (text.isEmpty) {
      _fetchHistorySight();
    } else {
      _interactor.saveSearchRequest(text);
      final places = <PlaceModel>[];
      try {
        final savedCategories = _prefs.fetchCategories();
        final savedDistance = _prefs.fetchDistance();
        int? radius;
        if (savedDistance != null) {
          radius = (savedDistance.end - savedDistance.start).toInt() * 1000;
        }
        final postModel = PostFilteredPlacesRequestModel(
          nameFilter: text,
          typeFilter: savedCategories,

          /// FIX: после добавления определения lng, lat
          // radius: radius,
        );
        places.addAll(await _interactor.searchPlaces(postModel));
      } on NetworkException catch (_) {
        currentState = ScreenState.error;
      }
      foundSights
        ..clear()
        ..addAll(
          places
              .where(
                (element) =>
                    element.name.toLowerCase().contains(text.toLowerCase()),
              )
              .toList(),
        );
      if (foundSights.isEmpty) {
        currentState = ScreenState.empty;
        notifyListeners();

        return;
      }
      currentState = ScreenState.success;
      notifyListeners();
    }
  }

  void removeSightFromHistory(String name) {
    _historySights.remove(name);
    _interactor.removeSearchRequest(name);
    if (_historySights.isEmpty) {
      currentState = ScreenState.empty;
    }
    notifyListeners();
  }

  void clearHistory() {
    _historySights.clear();
    _interactor.clearHistory();
    currentState = ScreenState.empty;
    notifyListeners();
  }

  void clearSearchBar() {
    searchController.clear();
    currentState = ScreenState.history;
    notifyListeners();
  }

  void _fetchHistorySight() {
    _historySights = _interactor.history;
    currentState =
        _historySights.isNotEmpty ? ScreenState.history : ScreenState.empty;
    notifyListeners();
  }
}
