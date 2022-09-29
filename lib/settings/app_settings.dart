import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/interactors/settings_interactor.dart';

class AppSettings extends ChangeNotifier {
  final SettingsInteractor _interactor;

  AppSettings(this._interactor);

  SystemUiOverlayStyle systemUiOverlayStyle() =>
      _interactor.systemUiOverlayStyle();

  ThemeData theme() => _interactor.theme();

  void changeAppMode() => changeAppMode();
}
