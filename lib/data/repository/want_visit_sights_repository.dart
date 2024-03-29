import 'package:places/data/sight_model.dart';

abstract class WantToVisitSightsRepository {
  List<SightModel>? fetchSights();

  void add(SightModel sight);

  void remove(SightModel sight);

  void removeAt(int index);

  void updateSights(List<SightModel> sights);
}
