import 'package:flutter/material.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/sight_details/widgets/body/bottom_buttons.dart';
import 'package:places/ui/widgets/green_circle_progress_indicator.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/svg_picture_colors.dart';

class BodyTextWidget extends StatelessWidget {
  final PlaceModel place;

  const BodyTextWidget({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.margin16,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Text(
              place.description,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            const _CreateRouteBtn(),
            const SizedBox(height: 24),
            const Divider(),
            const BottomButtonsWidget(),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

class _CreateRouteBtn extends StatefulWidget {
  const _CreateRouteBtn({Key? key}) : super(key: key);

  @override
  State<_CreateRouteBtn> createState() => _CreateRouteBtnState();
}

class _CreateRouteBtnState extends State<_CreateRouteBtn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedCrossFade(
      firstChild: SizedBox(
        height: AppDimensions.elevatedBtnHeight,
        width: AppDimensions.elevatedBtnWidth,
        child: ElevatedButton.icon(
          onPressed: () => setState(() => isLoading = true),
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
      ),
      secondChild: FutureBuilder(
        future: Future.delayed(
          const Duration(seconds: 10),
          () => setState(() => isLoading = false),
        ),
        builder: (context, snapshot) {
          return const Padding(
            padding: EdgeInsets.all(8),
            child: Center(child: GreenCircleProgressIndicator(size: 30)),
          );
        },
      ),
      crossFadeState:
          isLoading ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(seconds: 1),
    );
  }
}
