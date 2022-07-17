import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';

class EmptyPage extends StatelessWidget {
  final bool isVisited;

  const EmptyPage({Key? key, required this.isVisited}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isVisited)
          SvgPicture.asset(
            AppAssets.go,
          )
        else
          SvgPicture.asset(
            AppAssets.card,
          ),
        const SizedBox(
          height: AppDimensions.margin16,
        ),
        Text(
          AppStrings.empty,
          style: AppTypography.textText18Medium.copyWith(
            color: AppColors.grey,
          ),
        ),
        const SizedBox(
          height: AppDimensions.margin16,
        ),
        if (isVisited)
          Text(
            AppStrings.completeRoute,
            textAlign: TextAlign.center,
            style: AppTypography.textText14Regular.copyWith(
              color: AppColors.grey,
            ),
          )
        else
          Text(
            AppStrings.markFavouritePlaces,
            textAlign: TextAlign.center,
            style: AppTypography.textText14Regular.copyWith(
              color: AppColors.grey,
            ),
          ),
      ],
    );
  }
}
