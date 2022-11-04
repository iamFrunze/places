part of 'visited_place_bloc.dart';

@immutable
abstract class VisitedPlaceEvent {}

class VisitedPlaceRemoveEvent extends VisitedPlaceEvent {
  final PlaceModel place;

  VisitedPlaceRemoveEvent({required this.place});
}

class VisitedPlaceInitEvent extends VisitedPlaceEvent {}
