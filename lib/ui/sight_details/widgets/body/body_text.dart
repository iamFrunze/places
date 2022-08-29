import 'package:flutter/material.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/sight_details/widgets/body/bottom_buttons.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/svg_picture_colors.dart';

class BodyTextWidget extends StatelessWidget {
  final SightModel sight;

  const BodyTextWidget({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.margin16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              sight.details,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            const _CreateRouteBtn(),
            const SizedBox(height: 24),
            const Divider(),
            const BottomButtonsWidget(),
          ],
        ),
      ),
    );
  }
}

class _CreateRouteBtn extends StatelessWidget {
  const _CreateRouteBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: AppDimensions.elevatedBtnHeight,
      width: AppDimensions.elevatedBtnWidth,
      child: ElevatedButton.icon(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tap on route')),
        ),
        label: const Text(
          AppStrings.btnRoute,
        ),
        icon: IconSvg(
          icon: AppAssets.route,
          color: theme
              .extension<SvgPictureColors>()!
              .elevatedBtnActiveColor
              .toColor(),
        ),
      ),
    );
  }
}
