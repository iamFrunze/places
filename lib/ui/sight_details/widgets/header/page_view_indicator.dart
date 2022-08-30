import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/sight_details/sight_details_settings.dart';
import 'package:provider/provider.dart';

class PageViewIndicatorWidget extends StatelessWidget {
  final double width;

  const PageViewIndicatorWidget({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<SightDetailsSettings>().currentIndex;

    return Positioned(
      bottom: 0,
      child: AnimatedContainer(
        height: 8,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.cornerRadius8),
          ),
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.lmMainColorKit
              : AppColors.dmWhiteColorKit,
        ),
        margin: EdgeInsets.only(left: width * currentIndex),
        width: width,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}
