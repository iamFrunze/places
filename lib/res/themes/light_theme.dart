import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/res/themes/themes.dart';

class LightThemeData extends AppTheme {
  static ThemeData get base => ThemeData.light();

  @override
  Iterable<ThemeExtension> get extensions => extLight;

  OutlineInputBorder get _errorBorder => const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppDimensions.cornerRadius8,
          ),
        ),
        borderSide: BorderSide(
          color: AppColors.lmErrorBorderColor,
        ),
      );

  OutlineInputBorder get _focusedErrorBorder => const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppDimensions.cornerRadius8,
          ),
        ),
        borderSide: BorderSide(
          color: AppColors.lmErrorBorderColor,
          width: AppDimensions.borderWidth2,
        ),
      );

  OutlineInputBorder get _focusedBorder => const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppDimensions.cornerRadius8,
          ),
        ),
        borderSide: BorderSide(
          color: AppColors.lmFocusedBorderColor,
          width: AppDimensions.borderWidth2,
        ),
      );

  OutlineInputBorder get _enabledBorder => const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppDimensions.cornerRadius8,
          ),
        ),
        borderSide: BorderSide(color: AppColors.inactiveColorKit),
      );

  @override
  ThemeData buildTheme() {
    return base.copyWith(
      brightness: Brightness.light,
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
      sliderTheme: buildSliderTheme(),
      extensions: extensions,
      inputDecorationTheme: buildInputDecorationTheme(),
      textSelectionTheme: buildTextSelectionTheme(),
    );
  }

  @override
  TextTheme buildTextTheme() {
    return base.textTheme.copyWith(
      headlineMedium: AppTypography.headlineMedium.apply(
        color: AppColors.lmMainColorKit,
      ),
      headlineSmall: AppTypography.headlineSmall.apply(
        color: AppColors.lmSecondaryColorKit,
      ),
      titleMedium: AppTypography.titleMedium.apply(
        color: AppColors.inactiveColorKit,
      ),
      titleSmall: AppTypography.titleSmall.apply(
        color: AppColors.lmSecondaryColorKit,
      ),
      bodyLarge: AppTypography.bodyLarge.apply(
        color: AppColors.lmSecondaryColorKit,
      ),
      bodyMedium: AppTypography.bodyMedium.apply(
        color: AppColors.lmSecondaryColorKit,
      ),
      bodySmall: AppTypography.bodySmall.apply(
        color: AppColors.secondary2ColorKit,
      ),
      labelMedium: AppTypography.labelMedium.apply(
        color: AppColors.lmPrimaryColor,
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
        textStyle:
            MaterialStateProperty.all(AppTypography.labelMedium.copyWith()),
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
        textStyle: MaterialStateProperty.all(AppTypography.bodyMedium),
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
      labelStyle: AppTypography.bodyLarge,
      labelColor: AppColors.lmPrimaryColor,
      unselectedLabelStyle: AppTypography.bodyLarge,
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

  @override
  SliderThemeData buildSliderTheme() {
    return const SliderThemeData(
      activeTrackColor: AppColors.lmGreenColorKit,
      inactiveTrackColor: AppColors.inactiveColorKit,
    );
  }

  @override
  InputDecorationTheme buildInputDecorationTheme() {
    return base.inputDecorationTheme.copyWith(
      errorStyle: const TextStyle(height: 0),
      enabledBorder: _enabledBorder,
      focusedBorder: _focusedBorder,
      focusedErrorBorder: _focusedErrorBorder,
      errorBorder: _errorBorder,
    );
  }

  @override
  TextSelectionThemeData buildTextSelectionTheme() {
    return base.textSelectionTheme.copyWith(
      cursorColor: AppColors.lmOnPrimaryColor,
    );
  }
}
