import 'package:flutter/material.dart';

class AppSettingsModel extends ChangeNotifier {
  bool isDarkMode = false;

  void changeAppMode({bool value = false}) {
    isDarkMode = value;
    notifyListeners();
  }
}
