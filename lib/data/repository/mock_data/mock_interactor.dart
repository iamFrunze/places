import 'package:places/data/sight_model.dart';

abstract class MockInteractor {
  List<SightModel>? fetchSightsFromMock();

  List<SightModel>? fetchWantToVisitSightsFromMock();

  List<SightModel>? fetchVisitedSightsFromMock();

  List<String>? fetchHistoryMock();

  void addSightToHistoryMock(String sight);

  void updateHistoryMock(List<String> sights);

  void removeSight(SightModel sight);

  void removeSightFromHistory(String nameSight);

  void removeWantToVisitSight(SightModel sight);

  void removeVisitedSight(SightModel sight);

  void clearHistory();
}
