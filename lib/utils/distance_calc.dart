import 'dart:math';

double distanceBetween(
  double startLatitude,
  double startLongitude,
  double endLatitude,
  double endLongitude,
) {
  const earthRadius = 6378137.0;
  final dLat = _toRadians(endLatitude - startLatitude);
  final dLon = _toRadians(endLongitude - startLongitude);

  final a = pow(sin(dLat / 2), 2) +
      pow(sin(dLon / 2), 2) *
          cos(_toRadians(startLatitude)) *
          cos(_toRadians(endLatitude));
  final c = 2 * asin(sqrt(a));

  return earthRadius * c;
}

double _toRadians(double degree) {
  return degree * pi / 180;
}
