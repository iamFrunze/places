import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/data/interactors/search_interactor.dart';
import 'package:places/data/model/request_model/post_filtered_places_request_model.dart';
import 'package:places/data/repository/local/shared_preferences/local_sp_impl.dart';
import 'package:places/utils/routes/routes.dart';

enum SplashGoTo { goToOnBoarding, goToMain }

class SplashSettings extends ChangeNotifier {
  final LocalSPImpl _prefs;
  final SearchInteractor _interactor;
  SplashGoTo? splashRoute;

  SplashSettings(this._prefs, this._interactor);

  Future<void> navigateToNext(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5), _requestPlaces)
        .whenComplete(() => route(context));
  }

  void route(BuildContext context) {
    final isFirst = _prefs.fetchFirstLogin();
    if (isFirst) {
      _prefs.saveFirstLogin();
      Future.microtask(
        () => Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.toOnBoarding,
          (route) => false,
        ),
      );
    } else {
      Future.microtask(
        () => Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.toMain,
          (route) => false,
        ),
      );
    }
  }

  Future<void> _requestPlaces() async {
    ///lat":56.8490809,"lng":53.247786 example
    final position = await _determinePosition();
    final model = PostFilteredPlacesRequestModel(
      lng: 53.247786,
      lat: 56.8490809,
      radius: 10000,
    );

    // TODO(iam): в префы сохранить и передать на карту.
    final places = await _interactor.filteredPlaces(model);
    debugPrint('places ::: $places');
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return Geolocator.getCurrentPosition();
  }
}
