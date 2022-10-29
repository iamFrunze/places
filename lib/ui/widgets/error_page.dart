import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAssets.error,
          color: AppColors.inactiveColorKit,
        ),
        const SizedBox(
          height: AppDimensions.margin16,
        ),
        Text(
          AppStrings.error,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(
          height: AppDimensions.margin16,
        ),
        Text(
          AppStrings.errorDescription,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
