import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';

class EmptyPage extends StatelessWidget {
  final bool isVisited;

  const EmptyPage({Key? key, required this.isVisited}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isVisited)
          SvgPicture.asset(
            AppAssets.go,
            color: AppColors.inactiveColorKit,
          )
        else
          SvgPicture.asset(
            AppAssets.card,
            color: AppColors.inactiveColorKit,
          ),
        const SizedBox(
          height: AppDimensions.margin16,
        ),
        Text(
          AppStrings.empty,
          style: theme.textTheme.headline6,
        ),
        const SizedBox(
          height: AppDimensions.margin16,
        ),
        if (isVisited)
          Text(
            AppStrings.completeRoute,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyText1?.copyWith(color: AppColors.inactiveColorKit),
          )
        else
          Text(
            AppStrings.markFavouritePlaces,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyText1?.copyWith(color: AppColors.inactiveColorKit),
          ),
      ],
    );
  }
}
