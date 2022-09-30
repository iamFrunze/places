import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/interactors/settings_interactor.dart';

class AppSettings extends ChangeNotifier {
  final SettingsInteractor _interactor;
  bool get isDarkMode => _isDarkMode;

  var _isDarkMode = false;

  AppSettings(this._interactor);

  SystemUiOverlayStyle systemUiOverlayStyle() =>
      _interactor.systemUiOverlayStyle();

  ThemeData theme() => _interactor.theme();

  void changeAppMode() {
    _interactor.chageAppMode();
    _isDarkMode = _interactor.isDarkMode;
    notifyListeners();
  }
}
