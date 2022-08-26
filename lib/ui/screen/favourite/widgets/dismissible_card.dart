import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';

class DismissibleCardWidget extends StatelessWidget {
  final Widget card;
  final DismissDirectionCallback onDismissed;

  const DismissibleCardWidget({
    Key? key,
    required this.card,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: const _BackgroundDismissible(),
      child: card,
    );
  }
}

class _BackgroundDismissible extends StatelessWidget {
  const _BackgroundDismissible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimensions.cornerRadius16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: AppDimensions.margin16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.bucket),
                const SizedBox(height: 10),
                const Text(
                  AppStrings.remove,
                  style: AppTypography.dismissibleText12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
