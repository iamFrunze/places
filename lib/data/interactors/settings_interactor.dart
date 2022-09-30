import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/themes/dark_theme.dart';
import 'package:places/res/themes/light_theme.dart';

class SettingsInteractor {
  bool get isDarkMode => _isDarkMode;

  var _isDarkMode = false;

  SystemUiOverlayStyle systemUiOverlayStyle() => !_isDarkMode
      ? SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor: AppColors.lmPrimaryColor,
          statusBarColor: Colors.transparent,
        )
      : SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarColor: AppColors.dmMainColorKit,
          statusBarColor: Colors.transparent,
        );

  ThemeData theme() => !_isDarkMode
      ? LightThemeData().buildTheme()
      : DarkThemeData().buildTheme();

  void chageAppMode() => _isDarkMode = !isDarkMode;
}
