import 'package:flutter/material.dart';

class SvgPictureColors extends ThemeExtension<SvgPictureColors> {
  final HSVColor textBtnActiveColor;
  final HSVColor textBtnInactiveColor;
  final HSVColor elevatedBtnActiveColor;
  final HSVColor elevatedBtnInactiveColor;
  final HSVColor greenColor;

  const SvgPictureColors({
    required this.textBtnActiveColor,
    required this.textBtnInactiveColor,
    required this.elevatedBtnActiveColor,
    required this.elevatedBtnInactiveColor,
    required this.greenColor,
  });

  @override
  SvgPictureColors copyWith({
    HSVColor? textBtnActiveColor,
    HSVColor? textBtnInactiveColor,
    HSVColor? elevatedBtnActiveColor,
    HSVColor? elevatedBtnInactiveColor,
    HSVColor? greenColor,
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
            textBtnActiveColor: HSVColor.lerp(textBtnActiveColor, other.textBtnActiveColor, t) ??
                HSVColor.fromColor(Colors.transparent),
            textBtnInactiveColor:
                HSVColor.lerp(textBtnInactiveColor, other.textBtnInactiveColor, t) ??
                    HSVColor.fromColor(Colors.transparent),
            elevatedBtnActiveColor:
                HSVColor.lerp(elevatedBtnActiveColor, other.elevatedBtnActiveColor, t) ??
                    HSVColor.fromColor(Colors.transparent),
            elevatedBtnInactiveColor:
                HSVColor.lerp(elevatedBtnInactiveColor, other.elevatedBtnInactiveColor, t) ??
                    HSVColor.fromColor(Colors.transparent),
            greenColor: HSVColor.lerp(greenColor, other.greenColor, t) ??
                HSVColor.fromColor(Colors.transparent),
          );
  }
}
