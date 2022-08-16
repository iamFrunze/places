import 'package:places/data/sight_model.dart';

abstract class MockInteractor {
  List<SightModel>? fetchSightsFromMock();

  List<String>? fetchHistoryMock();

  void addSightToHistoryMock(String sight);

  void updateHistoryMock(List<String> sights);

  void removeSight(SightModel sight);

  void removeSightFromHistory(String nameSight);

  void clearHistory();
}
