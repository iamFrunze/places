import 'package:places/data/interactors/local/database.dart';
import 'package:places/data/interactors/local/places_interactor_local.dart';
import 'package:places/data/model/place_model.dart';

class PlacesInteractorLocalImpl extends PlacesInteractorLocal {
  final Database _db;

  PlacesInteractorLocalImpl(this._db);

  @override
  Future addToFavourite(PlaceModel place) async {
    await _db.into(_db.favouritePlacesItems).insert(
          FavouritePlacesItemsCompanion.insert(
            id: place.id,
            url: place.urls.isEmpty ? '' : place.urls.first,
            type: place.placeType,
            name: place.name,

            /// Late init
            plan: false,
            time: DateTime.now(),
          ),
        );
  }

  @override
  Future addToVisited(PlaceModel place) async {
    await _db.into(_db.visitedPlacesItems).insert(
          VisitedPlacesItemsCompanion.insert(
            id: place.id,
            url: place.urls.isEmpty ? '' : place.urls.first,
            type: place.placeType,
            name: place.name,

            /// Late init
            timeOpen: DateTime.now(),
            date: DateTime.now(),
          ),
        );
  }

  @override
  Future removeFromFavourite(int id) async {
    await (_db.delete(_db.favouritePlacesItems)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<List<PlaceModel>> fetchFavouritePlaces() async {
    return _db
        .select(_db.favouritePlacesItems)
        .map(
          (place) => PlaceModel(
            id: place.id,
            lat: 0,
            lng: 0,
            name: place.name,
            urls: [place.url],
            placeType: place.type,
            description: '',
          ),
        )
        .get();
  }

  @override
  Future<List<PlaceModel>> fetchVisitedPlaces() async {
    return _db
        .select(_db.visitedPlacesItems)
        .map(
          (place) => PlaceModel(
            id: place.id,
            lat: 0,
            lng: 0,
            name: place.name,
            urls: [place.url],
            placeType: place.type,
            description: '',
          ),
        )
        .get();
  }
}
