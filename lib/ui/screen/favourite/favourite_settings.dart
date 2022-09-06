import 'package:flutter/material.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/repository/visited_sights_repository.dart';
import 'package:places/data/repository/want_visit_sights_repository.dart';
import 'package:places/data/sight_model.dart';

class FavouriteSettings extends ChangeNotifier {
  final VisitedSightsRepository visitedSightsRepository;
  final WantToVisitSightsRepository wantVisitSightsRepository;
  ScreenState currentStateWantVisit = ScreenState.loading;
  ScreenState currentStateVisited = ScreenState.loading;

  bool isInitializedWantVisitDone = false;
  bool isInitializedVisitedDone = false;

  List<SightModel> get wantVisitSights => _wantVisitSights;

  List<SightModel> get visitedSights => _visitedSights;

  late List<SightModel> _wantVisitSights;
  late List<SightModel> _visitedSights;

  FavouriteSettings({
    required this.visitedSightsRepository,
    required this.wantVisitSightsRepository,
  }) {
    _initVisitedData();
    _initWantVisitData();
    currentStateWantVisit = isInitializedWantVisitDone
        ? _wantVisitSights.isNotEmpty
            ? ScreenState.success
            : ScreenState.empty
        : ScreenState.error;
    currentStateVisited = isInitializedVisitedDone
        ? _visitedSights.isNotEmpty
            ? ScreenState.success
            : ScreenState.empty
        : ScreenState.error;
  }

  void removeWantVisitData(SightModel sight) {
    wantVisitSightsRepository.remove(sight);
    if (_wantVisitSights.isEmpty) {
      currentStateWantVisit = ScreenState.empty;
    }
    notifyListeners();
  }

  void removeWantVisitDataAt(int index) {
    wantVisitSightsRepository.removeAt(index);
    if (_wantVisitSights.isEmpty) {
      currentStateWantVisit = ScreenState.empty;
    }
    notifyListeners();
  }

  void removeVisitedSight(SightModel sight) {
    visitedSightsRepository.remove(sight);
    if (_visitedSights.isEmpty) {
      currentStateVisited = ScreenState.empty;
    }
    notifyListeners();
  }

  void removeVisitedSightAt(int index) {
    visitedSightsRepository.removeAt(index);
    if (_visitedSights.isEmpty) {
      currentStateVisited = ScreenState.empty;
    }
    notifyListeners();
  }

  void changePositionVisitedSight(SightModel sight, int index) {
    _visitedSights.insert(index, sight);
    notifyListeners();
  }

  void changePositionWantVisitSight(SightModel sight, int index) {
    _wantVisitSights.insert(index, sight);
    notifyListeners();
  }

  void onAcceptWantVisitSights(SightModel sight, int index) {
    _wantVisitSights
      ..remove(sight)
      ..insert(index, sight);
    // final newList = _wantVisitSights;
    // wantVisitSightsRepository.updateSights(newList);
    // debugPrint('new $newList \n s $_wantVisit');
    notifyListeners();
  }

  void onAcceptVisitedSights(SightModel sight, int index) {
    _visitedSights
      ..remove(sight)
      ..insert(index, sight);
    // visitedSightsRepository.updateSights(_visitedSights);
    notifyListeners();
  }

  Future _initWantVisitData() async {
    final callbackWantToVisit = wantVisitSightsRepository.fetchSights();
    if (callbackWantToVisit != null) {
      _wantVisitSights = callbackWantToVisit;
      isInitializedWantVisitDone = true;
    }
  }

  Future _initVisitedData() async {
    final callbackVisitedSights = visitedSightsRepository.fetchSights();
    if (callbackVisitedSights != null) {
      _visitedSights = callbackVisitedSights;
      isInitializedVisitedDone = true;
    }
  }
}
