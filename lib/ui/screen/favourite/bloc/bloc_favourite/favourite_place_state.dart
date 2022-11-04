part of 'favourite_place_bloc.dart';

@immutable
abstract class FavouritePlaceState {}

class FavouritePlaceLoadingState extends FavouritePlaceState {}

class FavouritePlaceLoadingSuccessState extends FavouritePlaceState {
  final List<PlaceModel> favouritesPlaces;

  FavouritePlaceLoadingSuccessState({required this.favouritesPlaces});
}

class FavouritePlaceLoadingFailureState extends FavouritePlaceState {
  final int code;
  final String text;

  FavouritePlaceLoadingFailureState({required this.code, required this.text});
}
