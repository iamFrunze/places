import 'package:places/data/sight_model.dart';

abstract class WantToVisitSightsRepository {
  List<SightModel>? fetchSights();

  void removeSight(SightModel sight);
}
