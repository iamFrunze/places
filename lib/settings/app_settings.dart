import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  bool isDarkMode = false;

  void changeAppMode({bool value = false}) {
    isDarkMode = value;
    notifyListeners();
  }
}
