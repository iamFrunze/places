import 'package:mobx/mobx.dart';
import 'package:places/data/interactors/place_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/get_place_request_model.dart';

part 'sight_list_store.g.dart';

class SightListStore = SightListBase with _$SightListStore;

abstract class SightListBase with Store {
  final PlaceInteractor _interactor;

  @observable
  ObservableFuture<List<PlaceModel>> favouritePlaces =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<PlaceModel>> places = ObservableFuture.value([]);

  SightListBase(this._interactor);

  @action
  Future<void> fetchData() async {
    final futurePlaces = _interactor.getPlaces(
      model: const GetPlaceRequestModel(count: 5),
    );
    places = ObservableFuture(futurePlaces);
    final futureFavouritePlaces = _interactor.getFavouritesPlaces();
    favouritePlaces = ObservableFuture(futureFavouritePlaces);
  }

  @action
  Future<void> addToFavourite(PlaceModel place) async {
    final favouriteValues = favouritePlaces.value;
    if (favouriteValues != null) {
      if (favouriteValues.map((e) => e.id).contains(place.id)) {
        await _interactor.removeFromFavourites(place);
      } else {
        await _interactor.addToFavourites(place);
      }
    }
    final futureFavouritePlaces = _interactor.getFavouritesPlaces();
    favouritePlaces = ObservableFuture(futureFavouritePlaces);
  }
}
