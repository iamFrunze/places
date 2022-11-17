import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/themes/dark_theme.dart';
import 'package:places/res/themes/light_theme.dart';

class SettingsInteractor {
  SystemUiOverlayStyle systemUiOverlayStyle({required bool isDarkMode}) =>
      !isDarkMode
          ? SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarColor: AppColors.lmPrimaryColor,
              statusBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              systemNavigationBarColor: AppColors.dmMainColorKit,
              statusBarColor: Colors.transparent,
            );

  ThemeData theme({required bool isDarkMode}) => !isDarkMode
      ? LightThemeData().buildTheme()
      : DarkThemeData().buildTheme();
}
