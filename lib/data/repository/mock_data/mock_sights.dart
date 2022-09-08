import 'package:places/data/repository/sights_repository.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/mocks.dart';

class MockSights extends SightRepository {
  @override
  void clearHistory() => historyMock.clear();

  @override
  List<String>? fetchHistory() => historyMock;

  @override
  List<SightModel>? fetchSights() => mocks;

  @override
  void removeSight(SightModel sight) => mocks.remove(sight);

  @override
  void removeSightFromHistory(String nameSight) =>
      historyMock.remove(nameSight);

  @override
  void updateHistory(List<String> sights) => historyMock
    ..clear()
    ..addAll(sights);

  @override
  void addSightToHistory(String sight) => historyMock.add(sight);

  @override
  void updateSight(SightModel sight) {
    final index = mocks.indexWhere((element) => element.id == sight.id);
    if (index != -1) {
      mocks
        ..removeAt(index)
        ..insert(index, sight);
    } else {
      throw Exception('Sight not found');
    }
  }
}
