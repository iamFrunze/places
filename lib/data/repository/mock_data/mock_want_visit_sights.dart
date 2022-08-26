import 'package:places/data/repository/want_visit_sights_repository.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/mocks.dart';

class MockWantVisitSights extends WantToVisitSightsRepository {
  @override
  List<SightModel>? fetchSights() => wantToVisitSightsMock;

  @override
  void remove(SightModel sight) => wantToVisitSightsMock.remove(sight);

  @override
  void removeAt(int index) => wantToVisitSightsMock.removeAt(index);

  @override
  void updateSights(List<SightModel> sights) => wantToVisitSightsMock
    ..clear()
    ..addAll(sights);
}
