import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/res/themes/themes.dart';

class DarkThemeData extends AppTheme {
  static ThemeData get base => ThemeData.dark();

  @override
  Iterable<ThemeExtension> get extensions => extDark;

  OutlineInputBorder get _errorBorder => const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppDimensions.cornerRadius8,
          ),
        ),
        borderSide: BorderSide(
          color: AppColors.dmErrorBorderColor,
        ),
      );

  OutlineInputBorder get _focusedErrorBorder => const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppDimensions.cornerRadius8,
          ),
        ),
        borderSide: BorderSide(
          color: AppColors.dmErrorBorderColor,
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
          color: AppColors.dmFocusedBorderColor,
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
      brightness: Brightness.dark,
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
      sliderTheme: buildSliderTheme(),
      extensions: extensions,
      inputDecorationTheme: buildInputDecorationTheme(),
      textSelectionTheme: buildTextSelectionTheme(),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        modalBackgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  TextTheme buildTextTheme() {
    return base.textTheme.copyWith(
      headlineMedium: AppTypography.headlineMedium.apply(
        color: AppColors.dmWhiteColorKit,
      ),
      headlineSmall: AppTypography.headlineSmall.apply(
        color: AppColors.dmWhiteColorKit,
      ),
      titleMedium: AppTypography.titleMedium.apply(
        color: AppColors.inactiveColorKit,
      ),
      titleSmall: AppTypography.titleSmall.apply(
        color: AppColors.dmWhiteColorKit,
      ),
      bodyLarge: AppTypography.bodyLarge.apply(
        color: AppColors.secondary2ColorKit,
      ),
      bodyMedium: AppTypography.bodyMedium.apply(
        color: AppColors.dmWhiteColorKit,
      ),
      bodySmall: AppTypography.bodySmall.apply(
        color: AppColors.inactiveColorKit,
      ),
      labelMedium: AppTypography.labelMedium.apply(
        color: AppColors.dmWhiteColorKit,
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
        textStyle: MaterialStateProperty.all(AppTypography.labelMedium),
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
                ? AppColors.dmSurfaceColor
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
        textStyle: MaterialStateProperty.all(AppTypography.bodyMedium),
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
      labelStyle: AppTypography.bodyLarge,
      labelColor: AppColors.dmSecondaryColorKit,
      unselectedLabelStyle: AppTypography.bodyLarge,
      unselectedLabelColor: AppColors.secondary2ColorKit,
    );
  }

  @override
  IconThemeData buildIconTheme() {
    return base.iconTheme.copyWith(
      color: AppColors.dmPrimaryColor,
      size: AppDimensions.iconSize,
    );
  }

  @override
  SliderThemeData buildSliderTheme() {
    return const SliderThemeData(
      activeTrackColor: AppColors.dmGreenColorKit,
      inactiveTrackColor: AppColors.inactiveColorKit,
      thumbColor: AppColors.dmWhiteColorKit,
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
      cursorColor: AppColors.dmOnPrimaryColor,
    );
  }
}
