import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:places/data/interactors/local/places_interactor_local_impl.dart';
import 'package:places/data/interactors/search_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/model/request_model/post_filtered_places_request_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' hide MapType;

class MapSettings extends ChangeNotifier {
  final animation = const MapAnimation();

  final objects = <MapObject>[];
  final SearchInteractor _interactor;
  final PlacesInteractorLocalImpl _interactorLocal;

  final List<PlaceModel> _places = [];
  PlaceModel? selectedPlace;

  YandexMapController? controller;

  MapSettings(this._interactor, this._interactorLocal);

  Future<void> fetchFilteredData() async {
    final model = PostFilteredPlacesRequestModel(
      lng: 53.247786,
      lat: 56.8490809,
      radius: 10000,
    );
    final places = await _interactor.filteredPlaces(model);
    _places.addAll(places);
    await addToObjects(places);
  }

  Future<void> addToObjects(List<PlaceModel> places) async {
    for (final element in places) {
      objects.add(
        PlacemarkMapObject(
          mapId: MapObjectId('place${element.id}'),
          point: Point(
            longitude: element.lng,
            latitude: element.lat,
          ),
          onTap: onTapPlacemark,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> onTapPlacemark(PlacemarkMapObject object, Point _) async {
    final hasTargetPoint = objects[0].mapId.value == 'target_point';
    if (hasTargetPoint) {
      objects.removeAt(0);
    }
    objects.insert(
      0,
      PlacemarkMapObject(
        mapId: const MapObjectId('target_point'),
        point: object.point,
        opacity: 1,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            scale: 3,
            image: BitmapDescriptor.fromAssetImage(AppAssets.targetPoint),
          ),
        ),
        onTap: onTapPlacemark,
      ),
    );
    final mapId = object.mapId.value;
    if (mapId.contains('place')) {
      final idSelectedPlace = mapId.substring(5);
      if (_places.isNotEmpty) {
        selectedPlace = _places
            .firstWhere((element) => element.id == int.parse(idSelectedPlace));
      }
    }
    notifyListeners();
  }

  Future<void>? autoZoom() async {
    final currentPosition = await _determinePosition();
    await controller?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 12,
          target: Point(
            longitude: 53.246786,
            latitude: 56.8490809,
            // latitude: currentPosition.latitude,
            // longitude: currentPosition.longitude,
          ),
        ),
      ),
      animation: animation,
    );
    notifyListeners();
  }

  Future<void> setupController(YandexMapController controller) async {
    this.controller = controller;
    notifyListeners();
  }

  Future<bool> openNativeMap() async {
    await _interactorLocal.addToVisited(selectedPlace!);
    final isAvailable = await MapLauncher.isMapAvailable(
      MapType.yandexMaps,
    );
    if (isAvailable != null && isAvailable) {
      await MapLauncher.showMarker(
        mapType: MapType.yandexMaps,
        coords: Coords(selectedPlace!.lat, selectedPlace!.lng),
        title: selectedPlace!.name,
      );

      return true;
    } else {
      return false;
    }
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
    final location = await Geolocator.getCurrentPosition();
    final placemark = PlacemarkMapObject(
      mapId: const MapObjectId('user_pos'),
      point: Point(
        // latitude: location.latitude,
        // longitude: location.longitude,
        longitude: 53.246786,
        latitude: 56.8490809,
      ),
      opacity: 1,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          scale: 3,
          image: BitmapDescriptor.fromAssetImage(
            AppAssets.userPlacemark,
          ),
        ),
      ),
    );
    objects.add(placemark);
    notifyListeners();

    return location;
  }
}
