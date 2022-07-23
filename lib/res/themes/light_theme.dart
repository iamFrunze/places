import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/res/themes/themes.dart';

class LightThemeData extends AppTheme {
  static ThemeData get base => ThemeData.light();

  @override
  Iterable<ThemeExtension> get extensions => extLight;

  @override
  ThemeData buildTheme() {
    return base.copyWith(
      primaryColor: AppColors.lmPrimaryColor,
      scaffoldBackgroundColor: AppColors.lmBackgroundColor,
      disabledColor: AppColors.inactiveColorKit,
      textTheme: buildTextTheme(),
      colorScheme: buildColorScheme(),
      tabBarTheme: buildTabBarTheme(),
      appBarTheme: buildAppBarTheme(),
      canvasColor: AppColors.lmBackgroundColor,
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
        color: AppColors.lmSecondaryColorKit,
      ),
      headline5: AppTypography.headline5Bold.apply(
        color: AppColors.lmSecondaryColorKit,
      ),
      headline6: AppTypography.headline6Medium.apply(
        color: AppColors.inactiveColorKit,
      ),
      subtitle1: AppTypography.subtitle1Medium.apply(
        color: AppColors.lmSecondaryColorKit,
      ),
      subtitle2: AppTypography.subtitle2Bold.apply(
        color: AppColors.lmSecondaryColorKit,
      ),
      bodyText1: AppTypography.body1Regular.apply(
        color: AppColors.lmSecondaryColorKit,
      ),
      bodyText2: AppTypography.body2Regular.apply(
        color: AppColors.lmSecondary2ColorKit,
      ),
    );
  }

  @override
  AppBarTheme buildAppBarTheme() {
    return base.appBarTheme.copyWith(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.lmPrimaryColor,
      foregroundColor: AppColors.lmOnPrimaryColor,
    );
  }

  @override
  BottomNavigationBarThemeData buildBottomNavigationBarTheme() {
    return base.bottomNavigationBarTheme.copyWith(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: AppColors.lmUnselectedBottomNavBatItem,
      selectedItemColor: AppColors.lmSelectedBottomNavBatItem,
    );
  }

  @override
  ColorScheme buildColorScheme() {
    return base.colorScheme.copyWith(
      background: AppColors.lmBackgroundColor,
      onPrimary: AppColors.lmOnPrimaryColor,
      primary: AppColors.lmPrimaryColor,
      surface: AppColors.lmSurfaceColor,
      onSurface: AppColors.lmOnSurfaceColor,
      tertiary: AppColors.lmGreenColorKit,
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
                : AppColors.lmGreenColorKit;
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
        overlayColor: MaterialStateProperty.all(AppColors.lmSurfaceColor),
      ),
    );
  }

  @override
  TabBarTheme buildTabBarTheme() {
    return base.tabBarTheme.copyWith(
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.cornerRadius40),
        color: AppColors.lmSecondaryColorKit,
      ),
      labelStyle: AppTypography.textText14Bold,
      labelColor: AppColors.lmPrimaryColor,
      unselectedLabelStyle: AppTypography.textText14Bold,
      unselectedLabelColor: AppColors.inactiveColorKit,
    );
  }

  @override
  IconThemeData buildIconTheme() {
    return base.iconTheme.copyWith(
      color: AppColors.lmPrimaryColor,
      size: AppDimensions.iconSize,
    );
  }
}
