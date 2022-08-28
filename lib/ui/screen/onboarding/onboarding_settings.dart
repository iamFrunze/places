import 'package:flutter/material.dart';

class OnBoardingSettings extends ChangeNotifier {
  int get currentPage => _currentIndex;

  int _currentIndex = 0;

  void onPageChange(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
