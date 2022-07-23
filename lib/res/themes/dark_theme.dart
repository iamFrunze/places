import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/res/themes/themes.dart';

class DarkThemeData extends AppTheme {
  static ThemeData get base => ThemeData.dark();

  @override
  Iterable<ThemeExtension> get extensions => extDark;

  @override
  ThemeData buildTheme() {
    return base.copyWith(
      primaryColor: AppColors.dmPrimaryColor,
      scaffoldBackgroundColor: AppColors.dmBackgroundColor,
      disabledColor: AppColors.inactiveColorKit,
      textTheme: buildTextTheme(),
      colorScheme: buildColorScheme(),
      tabBarTheme: buildTabBarTheme(),
      appBarTheme: buildAppBarTheme(),
      canvasColor: AppColors.dmBackgroundColor,
      bottomNavigationBarTheme: buildBottomNavigationBarTheme(),
      elevatedButtonTheme: buildElevatedButtonTheme(),
      textButtonTheme: buildTextButtonTheme(),
      iconTheme: buildIconTheme(),
      extensions: extensions,
    );
  }

  @override
  TextTheme buildTextTheme() {
    return base.textTheme.copyWith(
      headline4: AppTypography.headline4Bold.apply(
        color: AppColors.dmWhiteColorKit,
      ),
      headline5: AppTypography.headline5Bold.apply(
        color: AppColors.dmWhiteColorKit,
      ),
      headline6: AppTypography.headline6Medium.apply(
        color: AppColors.inactiveColorKit,
      ),
      subtitle1: AppTypography.subtitle1Medium.apply(
        color: AppColors.dmWhiteColorKit,
      ),
      subtitle2: AppTypography.subtitle2Bold.apply(
        color: AppColors.dmWhiteColorKit,
      ),
      bodyText1: AppTypography.body1Regular.apply(
        color: AppColors.dmWhiteColorKit,
      ),
      bodyText2: AppTypography.body2Regular.apply(
        color: AppColors.dmSecondary2ColorKit,
      ),
    );
  }

  @override
  AppBarTheme buildAppBarTheme() {
    return base.appBarTheme.copyWith(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.dmPrimaryColor,
      foregroundColor: AppColors.dmOnPrimaryColor,
    );
  }

  @override
  BottomNavigationBarThemeData buildBottomNavigationBarTheme() {
    return base.bottomNavigationBarTheme.copyWith(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 5,
      unselectedItemColor: AppColors.dmUnselectedBottomNavBatItem,
      selectedItemColor: AppColors.dmSelectedBottomNavBatItem,
    );
  }

  @override
  ColorScheme buildColorScheme() {
    return base.colorScheme.copyWith(
      background: AppColors.dmBackgroundColor,
      onPrimary: AppColors.dmOnPrimaryColor,
      primary: AppColors.dmPrimaryColor,
      surface: AppColors.dmSurfaceColor,
      onSurface: AppColors.dmOnSurfaceColor,
      tertiary: AppColors.dmGreenColorKit,
    );
  }

  @override
  ElevatedButtonThemeData buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(AppTypography.elevatedButton),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.disabled)
                ? AppColors.inactiveColorKit
                : Colors.white;
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.disabled)
                ? AppColors.backgroundColorKit
                : AppColors.dmGreenColorKit;
          },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.cornerRadius12),
          ),
        ),
      ),
    );
  }

  @override
  TextButtonThemeData buildTextButtonTheme() {
    return TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(AppTypography.textButton),
        overlayColor: MaterialStateProperty.all(AppColors.dmSurfaceColor),
      ),
    );
  }

  @override
  TabBarTheme buildTabBarTheme() {
    return base.tabBarTheme.copyWith(
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.cornerRadius40),
        color: AppColors.dmWhiteColorKit,
      ),
      labelStyle: AppTypography.textText14Bold,
      labelColor: AppColors.dmSecondaryColorKit,
      unselectedLabelStyle: AppTypography.textText14Bold,
      unselectedLabelColor: AppColors.dmSecondary2ColorKit,
    );
  }

  @override
  IconThemeData buildIconTheme() {
    return base.iconTheme.copyWith(
      color: AppColors.dmPrimaryColor,
      size: AppDimensions.iconSize,
    );
  }
}
