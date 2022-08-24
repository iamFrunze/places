import 'package:places/data/sight_model.dart';

abstract class VisitedSightsRepository {
  List<SightModel>? fetchSights();

  void remove(SightModel sight);

  void removeAt(int index);

  void updateSights(List<SightModel> sights);
}
