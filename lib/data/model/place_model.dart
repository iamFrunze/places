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

  PlaceModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        lat = json['lat'] as double,
        lng = json['lng'] as double,
        name = json['name'] as String,
        urls = List<String>.from(
          (json['urls'] as List).map<String>((dynamic e) => e as String),
        ),
        placeType = json['placeType'] as String,
        description = json['description'] as String,
        distance = json['distance'] as double?;

  @override
  String toString() => 'PlaceModel(name: $name)';

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

  PlaceModel copyWith({
    int? id,
    double? lat,
    double? lng,
    String? name,
    List<String>? urls,
    String? placeType,
    String? description,
    double? distance,
  }) {
    return PlaceModel(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      name: name ?? this.name,
      urls: urls ?? this.urls,
      placeType: placeType ?? this.placeType,
      description: description ?? this.description,
      distance: distance ?? this.distance,
    );
  }
}
