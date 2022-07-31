import 'package:flutter/material.dart';
import 'package:places/utils/theme_data_ext_mixin.dart';

abstract class AppTheme with ThemeDataExt {
  Iterable<ThemeExtension> get extensions;

  ThemeData buildTheme();

  TextTheme buildTextTheme();

  ColorScheme buildColorScheme();

  TabBarTheme buildTabBarTheme();

  AppBarTheme buildAppBarTheme();

  BottomNavigationBarThemeData buildBottomNavigationBarTheme();

  ElevatedButtonThemeData buildElevatedButtonTheme();

  TextButtonThemeData buildTextButtonTheme();

  IconThemeData buildIconTheme();

  SliderThemeData buildSliderTheme();
}
