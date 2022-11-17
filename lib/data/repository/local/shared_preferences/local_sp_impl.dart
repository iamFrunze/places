import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/data/repository/local/shared_preferences/local_sp.dart';
import 'package:places/res/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSPImpl extends LocalSP {
  final SharedPreferences _prefs;

  LocalSPImpl(this._prefs);

  @override
  Future<bool> saveCategories(List<String> categories) async {
    try {
      return await _prefs.setStringList(AppStrings.categories, categories);
    } on IOException catch (_) {
      return false;
    }
  }

  @override
  Future<bool> saveDistance(RangeValues value) async {
    final fromValue = value.start;
    final toValue = value.end;
    try {
      final fromState = await _prefs.setDouble(
        AppStrings.fromRangeValueKey,
        fromValue,
      );
      final toState = await _prefs.setDouble(
        AppStrings.toRangeValueKey,
        toValue,
      );

      return fromState && toState;
    } on IOException catch (_) {
      return false;
    }
  }

  @override
  Future<bool> saveAppTheme({required bool isDarkMode}) async {
    try {
      return await _prefs.setBool(AppStrings.appThemeKey, isDarkMode);
    } on IOException catch (_) {
      return false;
    }
  }

  @override
  Future<bool> saveFirstLogin() async {
    try {
      return await _prefs.setBool(AppStrings.firstLoginKey, false);
    } on IOException catch (_) {
      return false;
    }
  }

  @override
  bool fetchAppTheme() {
    final callback = _prefs.getBool(AppStrings.appThemeKey);

    return callback ?? false;
  }

  @override
  List<String>? fetchCategories() =>
      _prefs.getStringList(AppStrings.categoriesKey);

  @override
  RangeValues? fetchDistance() {
    final toValue = _prefs.getDouble(AppStrings.toRangeValueKey);
    final fromValue = _prefs.getDouble(AppStrings.fromRangeValueKey);

    return toValue != null && fromValue != null
        ? RangeValues(fromValue, toValue)
        : null;
  }

  @override
  bool fetchFirstLogin() {
    final isFirstLogin = _prefs.getBool(AppStrings.firstLoginKey);

    return isFirstLogin ?? true;
  }
}
