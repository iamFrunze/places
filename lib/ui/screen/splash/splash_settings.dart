import 'package:flutter/material.dart';

class SplashSettings extends ChangeNotifier {
  bool isInitialized = false;

  Future<void> navigateToNext() async {
    await Future.delayed(const Duration(seconds: 5), () {
      debugPrint('Переход на следующий экран');
      isInitialized = true;
      notifyListeners();
    });
  }
}
