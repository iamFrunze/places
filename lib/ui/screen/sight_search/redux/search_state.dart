import 'dart:collection';

import 'package:places/data/model/place_model.dart';

abstract class SearchState {}

class ShowHistoryState extends SearchState {
  final LinkedHashSet<String> history;

  ShowHistoryState({required this.history});
}

class ShowPlacesState extends SearchState {
  final List<PlaceModel> places;
  final String request;

  ShowPlacesState(this.request, {required this.places});
}

class EmptyState extends SearchState {}

class ErrorState extends SearchState {}

class LoadingState extends SearchState {}
