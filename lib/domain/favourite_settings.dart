import 'package:flutter/material.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/repository/mock_data/mock_interactor_impl.dart';
import 'package:places/data/sight_model.dart';

class FavouriteSettings extends ChangeNotifier {
  final _mockRepo = MockInteractorImpl();
  CallbackState currentState = CallbackState.empty;

  List<SightModel> get wantToVisit => _wantToVisit;

  List<SightModel> get visitedSights => _visitedSights;

  late List<SightModel> _wantToVisit;
  late List<SightModel> _visitedSights;

  Future initWantToVisitData() async {
    final callbackWantToVisit = _mockRepo.fetchWantToVisitSightsFromMock();
    if (callbackWantToVisit != null) {
      _wantToVisit = callbackWantToVisit;
      currentState = CallbackState.success;
    } else {
      currentState = CallbackState.error;
    }
  }

  Future initVisitedData() async {
    final callbackVisitedSights = _mockRepo.fetchVisitedSightsFromMock();
    if (callbackVisitedSights != null) {
      _visitedSights = callbackVisitedSights;
      currentState = CallbackState.success;
    } else {
      currentState = CallbackState.error;
    }
  }

  void removeWantToVisitData(SightModel sight) {
    _wantToVisit.remove(sight);
    _mockRepo.removeWantToVisitSight(sight);
    if (_wantToVisit.isEmpty) {
      currentState = CallbackState.empty;
    }
    notifyListeners();
  }

  void removeVisitedSight(SightModel sight) {
    _visitedSights.remove(sight);
    _mockRepo.removeVisitedSight(sight);
    if (_visitedSights.isEmpty) {
      currentState = CallbackState.empty;
    }
    notifyListeners();
  }
}
