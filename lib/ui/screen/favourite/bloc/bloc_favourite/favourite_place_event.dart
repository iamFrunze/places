part of 'favourite_place_bloc.dart';

@immutable
abstract class FavouritePlaceEvent {}

class FavouritePlaceRemoveEvent extends FavouritePlaceEvent {
  final PlaceModel place;

  FavouritePlaceRemoveEvent({required this.place});
}

class FavouritePlaceInitEvent extends FavouritePlaceEvent {}
