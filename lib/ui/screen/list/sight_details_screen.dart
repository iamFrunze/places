import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/sight.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/planning_text_button.dart';
import 'package:places/ui/widgets/svg_picture_colors.dart';

class SightDetailsScreen extends StatelessWidget {
  final Sight sight;

  const SightDetailsScreen({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: AppStrings.heroTagCard,
                    child: Image.network(
                      sight.url,
                      loadingBuilder: (context, child, loadingProgress) {
                        return loadingProgress == null
                            ? child
                            : Container(
                                height: 400,
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
                    ),
                  ),
                  Container(
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
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tap on back')),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.back,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
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
                          color:
                              theme.extension<SvgPictureColors>()!.elevatedBtnActiveColor.toColor(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
