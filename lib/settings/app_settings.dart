import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/interactors/settings_interactor.dart';
import 'package:places/data/repository/local/shared_preferences/local_sp_impl.dart';

class AppSettings extends ChangeNotifier {
  final SettingsInteractor _interactor;
  final LocalSPImpl _prefs;

  bool get isDarkMode => _isDarkMode;
  var _isDarkMode = false;

  AppSettings(this._interactor, this._prefs) {
    _isDarkMode = _prefs.fetchAppTheme();
    notifyListeners();
  }

  SystemUiOverlayStyle systemUiOverlayStyle() =>
      _interactor.systemUiOverlayStyle(isDarkMode: _isDarkMode);

  ThemeData theme() => _interactor.theme(isDarkMode: _isDarkMode);

  void changeAppMode() {
    _isDarkMode = !_isDarkMode;
    _prefs.saveAppTheme(isDarkMode: _isDarkMode);
    notifyListeners();
  }
}
