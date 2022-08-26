import 'package:places/data/repository/visited_sights_repository.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/mocks.dart';

class MockVisitedSights extends VisitedSightsRepository {
  @override
  List<SightModel>? fetchSights() => visitedSightsMock;

  @override
  void remove(SightModel sight) => visitedSightsMock.remove(sight);

  @override
  void removeAt(int index) => visitedSightsMock.removeAt(index);

  @override
  void updateSights(List<SightModel> sights) => visitedSightsMock
    ..clear()
    ..addAll(sights);
}
