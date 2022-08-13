class CategoryModel {
  final String type;
  final String icon;
  bool value;

  CategoryModel({
    required this.type,
    required this.icon,
    this.value = false,
  });
}
