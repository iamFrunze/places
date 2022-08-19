import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';

enum EmptyPageState {
  wantToVisitSights,
  visitedSights,
}

class EmptyPage extends StatelessWidget {
  final EmptyPageState state;

  const EmptyPage({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state == EmptyPageState.visitedSights)
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
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppDimensions.margin16,
        ),
        if (state == EmptyPageState.visitedSights)
          Text(
            AppStrings.completeRoute,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          )
        else
          Text(
            AppStrings.markFavouritePlaces,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
      ],
    );
  }
}
