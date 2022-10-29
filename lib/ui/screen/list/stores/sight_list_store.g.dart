// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sight_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SightListStore on SightListBase, Store {
  late final _$favouritePlacesAtom =
      Atom(name: 'SightListBase.favouritePlaces', context: context);

  @override
  ObservableFuture<List<PlaceModel>> get favouritePlaces {
    _$favouritePlacesAtom.reportRead();
    return super.favouritePlaces;
  }

  @override
  set favouritePlaces(ObservableFuture<List<PlaceModel>> value) {
    _$favouritePlacesAtom.reportWrite(value, super.favouritePlaces, () {
      super.favouritePlaces = value;
    });
  }

  late final _$placesAtom =
      Atom(name: 'SightListBase.places', context: context);

  @override
  ObservableFuture<List<PlaceModel>> get places {
    _$placesAtom.reportRead();
    return super.places;
  }

  @override
  set places(ObservableFuture<List<PlaceModel>> value) {
    _$placesAtom.reportWrite(value, super.places, () {
      super.places = value;
    });
  }

  late final _$fetchDataAsyncAction =
      AsyncAction('SightListBase.fetchData', context: context);

  @override
  Future<void> fetchData() {
    return _$fetchDataAsyncAction.run(() => super.fetchData());
  }

  late final _$addToFavouriteAsyncAction =
      AsyncAction('SightListBase.addToFavourite', context: context);

  @override
  Future<void> addToFavourite(PlaceModel place) {
    return _$addToFavouriteAsyncAction.run(() => super.addToFavourite(place));
  }

  @override
  String toString() {
    return '''
favouritePlaces: ${favouritePlaces},
places: ${places}
    ''';
  }
}
