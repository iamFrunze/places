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

  ScreenState currentState = ScreenState.empty;

  List<SightModel> get sight => _sights;

  List<String> get historySights => _historySights;

  late List<SightModel> _sights;
  late List<String> _historySights;

  SearchSettings({
    required this.repository,
  });

  Future initData() async {
    final callback = repository.fetchSights();
    final callbackHistory = repository.fetchHistory();
    if (callback != null) {
      _sights = callback;
      debugPrint('sight $_sights');
    } else {
      currentState = ScreenState.error;
    }
    _historySights = callbackHistory != null && callbackHistory.isNotEmpty
        ? callbackHistory
        : [];
  }

  Future fetchSight({
    String text = '',
  }) async {
    currentState = ScreenState.loading;
    notifyListeners();
    //TODO имитация загрузки данных
    await Future.delayed(Duration(seconds: 5), () {});
    debugPrint('text $text');
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
      debugPrint('sights $foundSights');

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
}
