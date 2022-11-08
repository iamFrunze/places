import 'package:places/data/exceptions/network_exception.dart';
import 'package:places/data/interactors/search_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/ui/screen/sight_search/redux/actions.dart';
import 'package:places/ui/screen/sight_search/redux/search_state.dart';
import 'package:redux/redux.dart';

class SearchMiddleware extends MiddlewareClass<SearchState> {
  final SearchInteractor _interactor;

  SearchMiddleware(this._interactor);

  @override
  void call(
    Store<SearchState> store,
    dynamic action,
    NextDispatcher next,
  ) {
    if (action is FetchPlacesAction) {
      if (action.request.contains(' ')) {
        fetchSight(next, text: action.request);
      }
    }
    if (action is ClearSearchBarAction) {
      clearSearchBar(next);
    }
    if (action is ClearHistoryAction) {
      clearHistory(next);
    }
    if (action is RemovePlaceFromHistoryAction) {
      removeSightFromHistory(next, name: action.name);
    }
    if (action is ShowHistoryAction) {
      showHistory(next);
    }
  }

  Future showHistory(NextDispatcher next) async {
    final history = _interactor.history;

    next(MWShowHistoryAction(history: history));
  }

  Future fetchSight(
    NextDispatcher next, {
    String text = '',
  }) async {
    if (text.isEmpty) {
      final history = _interactor.history;
      if (history.isEmpty) {
        next(MWEmptySearchAction());
      } else {
        next(MWShowHistoryAction(history: history));
      }
    } else {
      _interactor.saveSearchRequest(text);
      final places = <PlaceModel>[];
      try {
        places.addAll(await _interactor.searchPlaces(text));
        if (places.isEmpty) {
          next(MWEmptySearchAction());
        } else {
          next(MWSuccessLoadAction(text, places: places));
        }
      } on NetworkException catch (_) {
        next(MWFetchErrorAction());
      }
    }
  }

  void removeSightFromHistory(
    NextDispatcher next, {
    required String name,
  }) {
    final history = _interactor.removeSearchRequest(name);
    if (history.isEmpty) {
      next(MWEmptySearchAction());
    } else {
      next(MWShowHistoryAction(history: history));
    }
  }

  void clearHistory(NextDispatcher next) {
    _interactor.clearHistory();
    next(MWEmptySearchAction());
  }

  void clearSearchBar(NextDispatcher next) {
    final history = _interactor.history;
    if (history.isEmpty) {
      next(MWEmptySearchAction());
    } else {
      next(MWShowHistoryAction(history: history));
    }
  }
}
