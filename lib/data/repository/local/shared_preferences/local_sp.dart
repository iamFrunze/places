import 'package:flutter/material.dart';

abstract class LocalSP {
  Future<bool> saveAppTheme({required bool isDarkMode});

  bool fetchAppTheme();

  Future<bool> saveCategories(List<String> categories);

  List<String>? fetchCategories();

  Future<bool> saveDistance(RangeValues value);

  RangeValues? fetchDistance();

  Future<bool> saveFirstLogin();

  bool fetchFirstLogin();
}
