import 'package:places/data/model/place_model.dart';

abstract class PlacesInteractorLocal {
  Future addToFavourite(PlaceModel place);

  Future removeFromFavourite(int id);

  Future addToVisited(PlaceModel place);

  Future fetchFavouritePlaces();

  Future fetchVisitedPlaces();
}
