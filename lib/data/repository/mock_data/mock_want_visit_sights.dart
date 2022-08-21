import 'package:places/data/repository/sights_repository.dart';
import 'package:places/data/repository/visited_sights_repository.dart';
import 'package:places/data/repository/want_visit_sights_repository.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/mocks.dart';

class MockWantVisitSights extends WantToVisitSightsRepository {
  @override
  List<SightModel>? fetchSights() => mocks;

  @override
  void removeSight(SightModel sight) => mocks.remove(sight);
}
