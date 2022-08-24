import 'package:flutter/material.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';

class ShowOnMapButtonWidget extends StatelessWidget {
  const ShowOnMapButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        AppStrings.showOnMap,
        style: AppTypography.textMedium16.copyWith(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
