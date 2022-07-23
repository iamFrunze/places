import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/ui/widgets/svg_picture_colors.dart';

mixin ThemeDataExt {
  final List<ThemeExtension> extLight = [
    SvgPictureColors(
      textBtnActiveColor: HSVColor.fromColor(AppColors.lmSecondaryColorKit),
      textBtnInactiveColor: HSVColor.fromColor(AppColors.inactiveColorKit),
      elevatedBtnActiveColor: HSVColor.fromColor(AppColors.lmPrimaryColor),
      elevatedBtnInactiveColor: HSVColor.fromColor(AppColors.inactiveColorKit),
      greenColor: HSVColor.fromColor(AppColors.lmGreenColorKit),
    ),
  ];

  final List<ThemeExtension> extDark = [
    SvgPictureColors(
      textBtnActiveColor: HSVColor.fromColor(AppColors.dmWhiteColorKit),
      textBtnInactiveColor: HSVColor.fromColor(AppColors.inactiveColorKit),
      elevatedBtnActiveColor: HSVColor.fromColor(AppColors.dmWhiteColorKit),
      elevatedBtnInactiveColor: HSVColor.fromColor(AppColors.inactiveColorKit),
      greenColor: HSVColor.fromColor(AppColors.dmGreenColorKit),
    ),
  ];
}
