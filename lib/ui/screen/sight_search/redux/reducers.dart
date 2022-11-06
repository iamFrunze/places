import 'package:places/ui/screen/sight_search/redux/actions.dart';
import 'package:places/ui/screen/sight_search/redux/search_state.dart';

class FetchHistoryPlacesAction extends MiddlewareActions {}

SearchState reducer(SearchState prev, dynamic action) {
  if (action is MWShowHistoryAction) {
    return ShowHistoryState(history: action.history);
  }
  if (action is MWFetchErrorAction) {
    return ErrorState();
  }
  if (action is MWSuccessLoadAction) {
    return ShowPlacesState(action.request, places: action.places);
  }
  if (action is MWEmptySearchAction) {
    return EmptyState();
  }

  return prev;
}
