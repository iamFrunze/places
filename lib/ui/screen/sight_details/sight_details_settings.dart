import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactors/local/places_interactor_local_impl.dart';
import 'package:places/data/interactors/remote/place_interactor_remote.dart';
import 'package:places/data/model/place_model.dart';

class SightDetailsSettings extends ChangeNotifier {
  final PlaceInteractorRemote _interactorRemote;
  final PlacesInteractorLocalImpl _interactorLocal;

  int get currentIndex => _currentIndex;

  String? get planningDate => _planningDate;

  bool get isFavourite => _isFavourite;

  bool _isFavourite = false;

  String? _planningDate;
  PlaceModel? _place;
  int _currentIndex = 0;

  SightDetailsSettings(this._interactorRemote, this._interactorLocal);

  void onPageChange(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void updatePlanningDateSight(DateTime date) {
    _planningDate = formatDate(
      date,
      [dd, ' ', M, ' ', yy],
      locale: const RussianDateLocale(),
    );
    notifyListeners();
  }

  Stream<PlaceModel> fetchPlace(int id) async* {
    final place = await _interactorRemote.getPlaceDetails(id);
    final favouritePlace = await _interactorLocal.fetchFavouritePlaces();
    _isFavourite = favouritePlace.map((e) => e.id).contains(place.id);
    _updateData(place);
    notifyListeners();
    yield place;
  }

  Future<void> addToFavourite() async {
    final favouritePlace = _place;

    if (favouritePlace != null) {
      if (!isFavourite) {
        await _interactorLocal.addToFavourite(favouritePlace);
      } else {
        await _interactorLocal.removeFromFavourite(favouritePlace.id);
      }
    } else {
      throw Exception('Place not found');
    }
    notifyListeners();
  }

  void _updateData(PlaceModel model) {
    if (_place != model) {
      _currentIndex = 0;
      _place = model;
      _planningDate = null;
    }
  }
}
