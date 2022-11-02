import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:places/data/exceptions/network_exception.dart';
import 'package:places/data/interactors/place_interactor_impl.dart';
import 'package:places/data/model/place_model.dart';

part 'favourite_place_event.dart';

part 'favourite_place_state.dart';

class FavouritePlaceBloc
    extends Bloc<FavouritePlaceEvent, FavouritePlaceState> {
  final PlaceInteractorImpl _interactor;

  FavouritePlaceBloc(this._interactor) : super(FavouritePlaceLoadingState()) {
    on<FavouritePlaceRemoveEvent>(_onRemove);
    on<FavouritePlaceInitEvent>(_init);
  }

  Future<void> _onRemove(
    FavouritePlaceRemoveEvent event,
    Emitter<FavouritePlaceState> emit,
  ) async {
    emit(FavouritePlaceLoadingState());
    final result = await _interactor.removeFromFavourites(event.place);
    emit(FavouritePlaceLoadingSuccessState(favouritesPlaces: result));
  }

  Future<void> _init(
    FavouritePlaceInitEvent event,
    Emitter<FavouritePlaceState> emit,
  ) async {
    emit(FavouritePlaceLoadingState());
    try {
      final result = await _interactor.getFavouritesPlaces();
      emit(FavouritePlaceLoadingSuccessState(favouritesPlaces: result));
    } on NetworkException catch (e) {
      emit(FavouritePlaceLoadingFailureState(
        code: e.code,
        text: e.nameError,
      ));
    }
  }
}
