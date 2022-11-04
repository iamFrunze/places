import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:places/data/exceptions/network_exception.dart';
import 'package:places/data/interactors/place_interactor_impl.dart';
import 'package:places/data/model/place_model.dart';

part 'visited_place_event.dart';

part 'visited_place_state.dart';

class VisitedPlaceBloc extends Bloc<VisitedPlaceEvent, VisitedPlaceState> {
  final PlaceInteractorImpl _interactor;

  VisitedPlaceBloc(this._interactor) : super(VisitedPlaceLoadingState()) {
    on<VisitedPlaceRemoveEvent>(_onRemove);
    on<VisitedPlaceInitEvent>(_init);
  }

  Future<void> _onRemove(
    VisitedPlaceRemoveEvent event,
    Emitter<VisitedPlaceState> emit,
  ) async {
    emit(VisitedPlaceLoadingState());
    final result = await _interactor.removeFromFavourites(event.place);
    emit(VisitedPlaceLoadingSuccessState(visitedPlaces: result));
  }

  Future<void> _init(
    VisitedPlaceInitEvent event,
    Emitter<VisitedPlaceState> emit,
  ) async {
    emit(VisitedPlaceLoadingState());
    try {
      final result = await _interactor.getFavouritesPlaces();
      emit(VisitedPlaceLoadingSuccessState(visitedPlaces: result));
    } on NetworkException catch (e) {
      emit(VisitedPlaceLoadingFailureState(
        code: e.code,
        text: e.nameError,
      ));
    }
  }
}
