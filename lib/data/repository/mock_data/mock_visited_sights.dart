import 'package:places/data/repository/sights_repository.dart';
import 'package:places/data/repository/visited_sights_repository.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/mocks.dart';

class MockVisitedSights extends VisitedSightsRepository {
  @override
  List<SightModel>? fetchSights() => mocks;

  @override
  void removeSight(SightModel sight) => mocks.remove(sight);
}
