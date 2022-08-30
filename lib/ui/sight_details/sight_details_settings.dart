import 'package:flutter/material.dart';

class SightDetailsSettings extends ChangeNotifier {
  int get currentIndex => _currentIndex;

  int _currentIndex = 0;

  void onPageChange(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
