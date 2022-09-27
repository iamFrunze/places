import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/interactors/search_interactor.dart';
import 'package:places/data/model/place_model.dart';

class SearchSettings extends ChangeNotifier {
  final searchController = TextEditingController();
  final foundSights = <PlaceModel>[];
  final SearchInteractor _interactor;

  bool initializedSights = false;
  ScreenState currentState = ScreenState.empty;

  LinkedHashSet<String> get historySights => _historySights;

  late LinkedHashSet<String> _historySights;

  SearchSettings(this._interactor) {
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
      final places = await _interactor.searchPlaces(text);
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
