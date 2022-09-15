import 'dart:convert';

class PlaceModel {
  final int id;
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;
  final double? distance;

  const PlaceModel({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
    this.distance,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        id: json['id'] as int,
        lat: json['lat'] as double,
        lng: json['lng'] as double,
        name: json['name'] as String,
        urls: List<String>.from(
          (json['urls'] as List<String>).map<String>((x) => x),
        ),
        placeType: json['placeType'] as String,
        description: json['description'] as String,
        distance: json['distance'] as double,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'lat': lat,
        'lng': lng,
        'name': name,
        'urls': urls,
        'placeType': placeType,
        'description': description,
        'distance': distance,
      };
}
