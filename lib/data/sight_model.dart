class SightModel {
  final String name;
  final double lat;
  final double lon;
  final String url;
  final String details;
  final String type;
  bool isSelect;

  SightModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
    this.isSelect = false,
  });

  @override
  String toString() {
    return '\n'
        'name ::: $name \n'
        'type ::: $type \n'
        'isSelect ::: $isSelect';
  }
}