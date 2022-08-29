import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/list/sight_details_settings.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/planning_text_button.dart';
import 'package:places/ui/widgets/svg_picture_colors.dart';
import 'package:provider/provider.dart';

class SightDetailsScreen extends StatelessWidget {
  final SightModel sight;

  const SightDetailsScreen({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _HeaderImage(
                sight: sight,
              ),
              _BodyText(sight: sight),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  final SightModel sight;

  const _HeaderImage({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Stack(
      children: [
        _PageViewImage(
          sight: sight,
          pageController: pageController,
        ),
        _PageViewIndicator(
          width: MediaQuery.of(context).size.width / 7,
        ),
        const _BtnOnBack(),
      ],
    );
  }
}

class _PageViewImage extends StatelessWidget {
  final SightModel sight;
  final PageController pageController;

  const _PageViewImage({
    Key? key,
    required this.sight,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: PageView.builder(
        controller: pageController,
        itemCount: 7,
        onPageChanged: context.read<SightDetailsSettings>().onPageChange,
        itemBuilder: (context, index) {
          return Image.network(
            sight.url,
            loadingBuilder: (context, child, loadingProgress) {
              return loadingProgress == null
                  ? child
                  : Container(
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
            },
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

class _PageViewIndicator extends StatefulWidget {
  final double width;

  const _PageViewIndicator({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  State<_PageViewIndicator> createState() => _PageViewIndicatorState();
}

class _PageViewIndicatorState extends State<_PageViewIndicator> {
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
        margin: EdgeInsets.only(left: widget.width * currentIndex),
        width: widget.width,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}

class _BtnOnBack extends StatelessWidget {
  const _BtnOnBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.iconBorderSize,
      width: AppDimensions.iconBorderSize,
      margin: const EdgeInsets.only(
        top: AppDimensions.margin32,
        left: AppDimensions.margin16,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.cornerRadius10),
        ),
        color: Theme.of(context).primaryColor,
      ),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: SvgPicture.asset(
          AppAssets.back,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}

class _BodyText extends StatelessWidget {
  final SightModel sight;

  const _BodyText({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.margin16,
        vertical: AppDimensions.margin24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sight.name,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                sight.type.toLowerCase(),
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(width: 16),
              Text(
                'закрыто до 09:00'.toLowerCase(),
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            sight.details,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          SizedBox(
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
          ),
          const SizedBox(height: 24),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PlanningTextButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tap on plan')),
                ),
                icon: AppAssets.calendar,
                label: AppStrings.plan,
              ),
              PlanningTextButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tap on favourite')),
                ),
                icon: AppAssets.heart,
                label: AppStrings.addToFavourite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
