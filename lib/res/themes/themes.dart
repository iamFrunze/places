import 'package:flutter/material.dart';
import 'package:places/ui/widgets/svg_picture_colors.dart';

abstract class AppTheme {
  ThemeData buildTheme();

  TextTheme buildTextTheme();

  ColorScheme buildColorScheme();

  TabBarTheme buildTabBarTheme();

  AppBarTheme buildAppBarTheme();

  BottomNavigationBarThemeData buildBottomNavigationBarTheme();

  ElevatedButtonThemeData buildElevatedButtonTheme();

  TextButtonThemeData buildTextButtonTheme();

  IconThemeData buildIconTheme();

  SvgPictureColors buildSvgPictureColor();
}
