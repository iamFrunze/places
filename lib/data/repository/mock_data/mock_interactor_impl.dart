import 'package:places/data/repository/mock_data/mock_interactor.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/mocks.dart';

class MockInteractorImpl extends MockInteractor {
  @override
  void clearHistory() => historyMock.clear();

  @override
  List<String>? fetchHistoryMock() => historyMock;

  @override
  List<SightModel>? fetchSightsFromMock() => mocks;

  @override
  List<SightModel>? fetchVisitedSightsFromMock() => visitedSights;

  @override
  List<SightModel>? fetchWantToVisitSightsFromMock() => wantToVisitSights;

  @override
  void removeSight(SightModel sight) => mocks.remove(sight);

  @override
  void removeSightFromHistory(String nameSight) =>
      historyMock.remove(nameSight);

  @override
  void updateHistoryMock(List<String> sights) => historyMock
    ..clear()
    ..addAll(sights);

  @override
  void addSightToHistoryMock(String sight) => historyMock.add(sight);

  @override
  void removeVisitedSight(SightModel sight) => visitedSights.remove(sight);

  @override
  void removeWantToVisitSight(SightModel sight) =>
      wantToVisitSights.remove(sight);
}
