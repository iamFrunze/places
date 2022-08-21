import 'package:flutter/material.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/repository/visited_sights_repository.dart';
import 'package:places/data/repository/want_visit_sights_repository.dart';
import 'package:places/data/sight_model.dart';

class FavouriteSettings extends ChangeNotifier {
  final VisitedSightsRepository visitedSightsRepository;
  final WantToVisitSightsRepository wantToVisitSightsRepository;
  ScreenState currentState = ScreenState.loading;

  List<SightModel> get wantToVisit => _wantToVisit;

  List<SightModel> get visitedSights => _visitedSights;

  late List<SightModel> _wantToVisit;
  late List<SightModel> _visitedSights;

  FavouriteSettings({
    required this.visitedSightsRepository,
    required this.wantToVisitSightsRepository,
  });

  Future initWantToVisitData() async {
    final callbackWantToVisit = wantToVisitSightsRepository.fetchSights();
    if (callbackWantToVisit != null) {
      _wantToVisit = callbackWantToVisit;
      currentState = ScreenState.success;
    } else {
      currentState = ScreenState.error;
    }
  }

  Future initVisitedData() async {
    final callbackVisitedSights = visitedSightsRepository.fetchSights();
    if (callbackVisitedSights != null) {
      _visitedSights = callbackVisitedSights;
      currentState = ScreenState.success;
    } else {
      currentState = ScreenState.error;
    }
  }

  void removeWantToVisitData(SightModel sight) {
    _wantToVisit.remove(sight);
    wantToVisitSightsRepository.removeSight(sight);
    if (_wantToVisit.isEmpty) {
      currentState = ScreenState.empty;
    }
    notifyListeners();
  }

  void removeVisitedSight(SightModel sight) {
    _visitedSights.remove(sight);
    visitedSightsRepository.removeSight(sight);
    if (_visitedSights.isEmpty) {
      currentState = ScreenState.empty;
    }
    notifyListeners();
  }
}
