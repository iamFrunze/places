import 'package:places/data/sight_model.dart';

abstract class SightRepository {
  List<SightModel>? fetchSights();

  List<String>? fetchHistory();

  void addSightToHistory(String sight);

  void updateHistory(List<String> sights);

  void removeSight(SightModel sight);

  void removeSightFromHistory(String nameSight);

  void clearHistory();
}
