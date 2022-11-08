import 'dart:collection';

import 'package:places/data/model/place_model.dart';

abstract class SearchAction {}

class FetchPlacesAction extends SearchAction {
  final String request;

  FetchPlacesAction({required this.request});
}

class ClearSearchBarAction extends SearchAction {}

class ClearHistoryAction extends SearchAction {}

class RemovePlaceFromHistoryAction extends SearchAction {
  final String name;

  RemovePlaceFromHistoryAction({required this.name});
}

class ShowHistoryAction extends SearchAction {}

abstract class MiddlewareActions {}

class MWShowHistoryAction extends MiddlewareActions {
  final LinkedHashSet<String> history;

  MWShowHistoryAction({required this.history});
}

class MWFetchErrorAction extends MiddlewareActions {}

class MWSuccessLoadAction extends MiddlewareActions {
  final List<PlaceModel> places;
  final String request;

  MWSuccessLoadAction(this.request, {required this.places});
}

class MWEmptySearchAction extends MiddlewareActions {}
