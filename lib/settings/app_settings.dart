import 'package:flutter/material.dart';
import 'package:places/data/category_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_strings.dart';

class AppSettings extends ChangeNotifier {
  static const rangeStart = 0.0;
  static const rangeEnd = 10.0;
  static const range = RangeValues(rangeStart, rangeEnd);

  static final categories = [
    CategoryModel(type: AppStrings.hotel, icon: AppAssets.hotel),
    CategoryModel(type: AppStrings.restaurant, icon: AppAssets.restaurant),
    CategoryModel(type: AppStrings.specialPlace, icon: AppAssets.specialPlace),
    CategoryModel(type: AppStrings.park, icon: AppAssets.park),
    CategoryModel(type: AppStrings.museum, icon: AppAssets.museum),
    CategoryModel(type: AppStrings.cafe, icon: AppAssets.cafe),
  ];

  bool isDarkMode = false;

  void changeAppMode({bool value = false}) {
    isDarkMode = value;
    notifyListeners();
  }
}
