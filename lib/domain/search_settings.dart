import 'package:flutter/material.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/domain/interactors/mock_data/mock_interactor_impl.dart';
import 'package:places/mocks.dart';
import 'package:places/utils/distance_calc.dart';

class SearchSettings extends ChangeNotifier {
  final searchController = TextEditingController();
  final foundSights = <SightModel>[];
  final _mockRepo = MockInteractorImpl();

  CallbackState currentState = CallbackState.empty;

  List<SightModel> get sight => _sights;

  List<String> get historySights => _historySights;

  late List<SightModel> _sights;
  late List<String> _historySights;

  Future initData() async {
    final callback = _mockRepo.fetchSightsFromMock();
    final callbackHistory = _mockRepo.fetchHistoryMock();
    if (callback != null) {
      _sights = callback;
      debugPrint('sight $_sights');
    } else {
      currentState = CallbackState.error;
    }
    _historySights = callbackHistory != null && callbackHistory.isNotEmpty
        ? callbackHistory
        : [];
  }

  Future fetchSight({
    String text = '',
  }) async {
    currentState = CallbackState.loading;
    notifyListeners();
    //TODO имитация загрузки данных
    await Future.delayed(Duration(seconds: 5), () {});
    debugPrint('text $text');
    if (text.isEmpty) {
      _fetchHistorySight();
    } else {
      _mockRepo.addSightToHistoryMock(text);
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
        currentState = CallbackState.empty;

        return;
      }
      currentState = CallbackState.success;
      notifyListeners();
    }
  }

  void removeSightFromHistory(String text) {
    _historySights.remove(text);
    _mockRepo.removeSightFromHistory(text);
    if (_historySights.isEmpty) {
      currentState = CallbackState.empty;
      notifyListeners();
    }
    notifyListeners();
  }

  void clearHistory() {
    _historySights.clear();
    _mockRepo.clearHistory();
    currentState = CallbackState.empty;
    notifyListeners();
  }

  void clearSearchBar() {
    searchController.clear();
    currentState = CallbackState.history;
    notifyListeners();
  }

  void _fetchHistorySight() {
    final callback = _mockRepo.fetchHistoryMock();
    if (callback != null && callback.isNotEmpty) {
      currentState = CallbackState.history;
      _historySights = callback;
    } else {
      currentState = CallbackState.empty;
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
