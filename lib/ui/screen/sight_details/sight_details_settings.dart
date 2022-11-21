import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:places/data/interactors/place_interactor_remote.dart';
import 'package:places/data/model/place_model.dart';

class SightDetailsSettings extends ChangeNotifier {
  final PlaceInteractorRemote _interactor;

  int get currentIndex => _currentIndex;

  String? get planningDate => _planningDate;

  bool get isFavourite => _isFavourite;

  bool _isFavourite = false;

  String? _planningDate;
  PlaceModel? _place;
  int _currentIndex = 0;

  SightDetailsSettings(this._interactor);

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
    final place = await _interactor.getPlaceDetails(id);
    final favouritePlace = await _interactor.getFavouritesPlaces();
    _isFavourite = favouritePlace.map((e) => e.id).contains(place.id);
    _updateData(place);
    notifyListeners();
    yield place;
  }

  Future<void> addToFavourite() async {
    final favouritePlace = _place;

    if (favouritePlace != null) {
      if (!isFavourite) {
        await _interactor.addToFavourites(favouritePlace);
      } else {
        await _interactor.removeFromFavourites(favouritePlace);
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
