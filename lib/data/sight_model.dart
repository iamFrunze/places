class SightModel {
  final int id;
  final String name;
  final double lat;
  final double lon;
  final String url;
  final String details;
  final String type;
  final String? planningDate;
  bool isSelect;

  SightModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
    this.planningDate,
    this.isSelect = false,
  });

  @override
  String toString() {
    return '\n'
        'name ::: $name \n'
        'type ::: $type \n'
        'isSelect ::: $isSelect';
  }

  SightModel copyWith({
    int? id,
    String? name,
    double? lat,
    double? lon,
    String? url,
    String? details,
    String? type,
    String? planningDate,
    bool? isSelect,
  }) {
    return SightModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      url: url ?? this.url,
      details: details ?? this.details,
      type: type ?? this.type,
      planningDate: planningDate ?? this.planningDate,
      isSelect: isSelect ?? this.isSelect,
    );
  }

  SightModel update(SightModel sight) {
    return SightModel(
      id: sight.id,
      name: sight.name,
      lat: sight.lat,
      lon: sight.lon,
      url: sight.url,
      details: sight.details,
      type: sight.type,
      planningDate: sight.planningDate,
      isSelect: sight.isSelect,
    );
  }
}
