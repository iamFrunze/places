import 'package:flutter/material.dart';

class SvgPictureColors extends ThemeExtension<SvgPictureColors> {
  final Color? textBtnActiveColor;
  final Color? textBtnInactiveColor;
  final Color? elevatedBtnActiveColor;
  final Color? elevatedBtnInactiveColor;
  final Color? greenColor;

  const SvgPictureColors({
    required this.textBtnActiveColor,
    required this.textBtnInactiveColor,
    required this.elevatedBtnActiveColor,
    required this.elevatedBtnInactiveColor,
    required this.greenColor,
  });

  @override
  SvgPictureColors copyWith({
    Color? textBtnActiveColor,
    Color? textBtnInactiveColor,
    Color? elevatedBtnActiveColor,
    Color? elevatedBtnInactiveColor,
    Color? greenColor,
  }) {
    return SvgPictureColors(
      textBtnActiveColor: textBtnActiveColor ?? this.textBtnActiveColor,
      textBtnInactiveColor: textBtnInactiveColor ?? this.textBtnInactiveColor,
      elevatedBtnActiveColor: elevatedBtnActiveColor ?? this.elevatedBtnActiveColor,
      elevatedBtnInactiveColor: elevatedBtnInactiveColor ?? this.elevatedBtnInactiveColor,
      greenColor: greenColor ?? this.greenColor,
    );
  }

  @override
  SvgPictureColors lerp(ThemeExtension<SvgPictureColors>? other, double t) {
    return other is! SvgPictureColors
        ? this
        : SvgPictureColors(
            textBtnActiveColor: Color.lerp(textBtnActiveColor, other.textBtnActiveColor, t),
            textBtnInactiveColor: Color.lerp(textBtnInactiveColor, other.textBtnInactiveColor, t),
            elevatedBtnActiveColor:
                Color.lerp(elevatedBtnActiveColor, other.elevatedBtnActiveColor, t),
            elevatedBtnInactiveColor:
                Color.lerp(elevatedBtnInactiveColor, other.elevatedBtnInactiveColor, t),
            greenColor: Color.lerp(greenColor, other.greenColor, t),
          );
  }
}
