import 'package:places/data/sight_model.dart';

abstract class VisitedSightsRepository {
  List<SightModel>? fetchSights();

  void removeSight(SightModel sight);
}
