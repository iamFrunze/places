import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
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
                    margin: const EdgeInsets.only(
                      top: AppDimensions.margin32,
                      left: AppDimensions.margin16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(AppDimensions.cornerRadius10),
                      ),
                      color: theme.primaryColor,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: theme.colorScheme.onPrimary,
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
                      style: theme.textTheme.headline5,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          sight.type.toLowerCase(),
                          style: theme.textTheme.subtitle2,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'закрыто до 09:00'.toLowerCase(),
                          style: theme.textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      sight.details,
                      style: theme.textTheme.bodyText1,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 48,
                      width: double.maxFinite,
                      child: ElevatedButton.icon(
                        onPressed: () {},
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
                        const PlanningTextButton(
                          onPressed: null,
                          icon: AppAssets.calendar,
                          label: AppStrings.plan,
                        ),
                        PlanningTextButton(
                          onPressed: () {},
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
