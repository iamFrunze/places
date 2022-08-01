import 'dart:math';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:places/data/sight.dart';
import 'package:places/mocks.dart';

class FilterSettings extends ChangeNotifier {
  final _selectedItem = List.generate(6, (index) => false);
  final _sights = mocks;
  int countNearSights = mocks.length;
  double _start = 0;
  double _end = 10;

  Future selectSight({
    required int index,
    required String type,
    required bool value,
  }) async {
    _selectedItem[index] = value;
    _sights.where((element) => element.type == type).map((e) => e.isSelect = value).toList();
    await _fetchNearSights();
  }

  Future changArea({
    required double start,
    required double end,
  }) async {
    _start = start;
    _end = end;
    await _fetchNearSights();
  }

  Future clearData() async {
    _sights.map((e) => e.isSelect = false).toList();
    _selectedItem.where((element) => element).map((e) => false).toList();
    await _fetchNearSights();
  }

  Future<List<Sight>> _fetchNearSights() async {
    final location = Location();
    final position = await location.getLocation();
    final area = (_end - _start) * 1000;
    final mapSights = <Sight>[];

    if (_selectedItem.contains(true)) {
      mapSights.addAll(_sights.where((element) => element.isSelect));
    } else {
      mapSights.addAll(_sights);
    }

    mapSights.map((sight) {
      final dist = _distanceBetween(
        position.latitude ?? 0,
        position.longitude ?? 0,
        sight.lat,
        sight.lon,
      );
      if (dist < area) {
        return sight;
      }
    }).toList();

    countNearSights = mapSights.length;
    notifyListeners();

    return mapSights;
  }

  double _distanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    const earthRadius = 6378137.0;
    final dLat = _toRadians(endLatitude - startLatitude);
    final dLon = _toRadians(endLongitude - startLongitude);

    final a = pow(sin(dLat / 2), 2) +
        pow(sin(dLon / 2), 2) * cos(_toRadians(startLatitude)) * cos(_toRadians(endLatitude));
    final c = 2 * asin(sqrt(a));

    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
