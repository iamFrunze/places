import 'package:flutter/material.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/repository/sights_repository.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/mocks.dart';
import 'package:places/utils/distance_calc.dart';

class SearchSettings extends ChangeNotifier {
  final searchController = TextEditingController();
  final foundSights = <SightModel>[];
  final SightRepository repository;

  bool initializedSights = false;
  ScreenState currentState = ScreenState.empty;

  List<SightModel> get sight => _sights;

  List<String> get historySights => _historySights;

  late List<SightModel> _sights;
  late List<String> _historySights;

  SearchSettings({required this.repository}) {
    _initData();
    currentState = initializedSights
        ? _sights.isNotEmpty
            ? ScreenState.success
            : ScreenState.empty
        : ScreenState.error;
  }

  Future fetchSight({
    String text = '',
  }) async {
    currentState = ScreenState.loading;
    notifyListeners();
    if (text.isEmpty) {
      _fetchHistorySight();
    } else {
      repository.addSightToHistory(text);
      historySights.add(text);
      foundSights
        ..clear()
        ..addAll(
          _sights
              .where(_isNear)
              .where(
                (element) =>
                    element.name.toLowerCase().contains(text.toLowerCase()),
              )
              .toList(),
        );

      if (foundSights.isEmpty) {
        currentState = ScreenState.empty;

        return;
      }
      currentState = ScreenState.success;
      notifyListeners();
    }
  }

  void removeSightFromHistory(String text) {
    _historySights.remove(text);
    repository.removeSightFromHistory(text);
    if (_historySights.isEmpty) {
      currentState = ScreenState.empty;
      notifyListeners();
    }
    notifyListeners();
  }

  void clearHistory() {
    _historySights.clear();
    repository.clearHistory();
    currentState = ScreenState.empty;
    notifyListeners();
  }

  void clearSearchBar() {
    searchController.clear();
    currentState = ScreenState.history;
    notifyListeners();
  }

  void _fetchHistorySight() {
    final callback = repository.fetchHistory();
    if (callback != null && callback.isNotEmpty) {
      currentState = ScreenState.history;
      _historySights = callback;
    } else {
      currentState = ScreenState.empty;
      _historySights = [];
    }
    notifyListeners();
  }

  bool _isNear(SightModel sight) {
    const area = (rangeEnd - rangeStart) * 1000;

    final dist = distanceBetween(
      mockLat,
      mockLot,
      sight.lat,
      sight.lon,
    );

    return dist < area;
  }

  Future _initData() async {
    final callback = repository.fetchSights();
    final callbackHistory = repository.fetchHistory();
    if (callback != null) {
      _sights = callback;
      initializedSights = true;
    }
    _historySights = callbackHistory ?? [];
  }
}
