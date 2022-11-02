part of 'visited_place_bloc.dart';

@immutable
abstract class VisitedPlaceState {}

class VisitedPlaceLoadingState extends VisitedPlaceState {}

class VisitedPlaceLoadingSuccessState extends VisitedPlaceState {
  final List<PlaceModel> visitedPlaces;

  VisitedPlaceLoadingSuccessState({required this.visitedPlaces});
}

class VisitedPlaceLoadingFailureState extends VisitedPlaceState {
  final int code;
  final String text;

  VisitedPlaceLoadingFailureState({required this.code, required this.text});
}
