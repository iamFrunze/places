class PostFilteredPlacesRequestModel {
  final double? lat;
  final double? lng;
  final double? radius;
  final List<String>? typeFilter;
  final String? nameFilter;

  const PostFilteredPlacesRequestModel({
    this.lat,
    this.lng,
    this.radius,
    this.typeFilter,
    this.nameFilter,
  })  : assert(!((lat != null) ^ (lng != null))),
        assert(!((lng != null) ^ (radius != null))),
        assert(!((radius != null) ^ (lat != null)));

  Map<String, dynamic> toJson() => <String, dynamic>{
        'lat': lat,
        'lng': lng,
        'radius': radius,
        'typeFilter': typeFilter != null
            ? List<String>.from(typeFilter!.map<String>((x) => x))
            : null,
        'nameFilter': nameFilter,
      };
}
