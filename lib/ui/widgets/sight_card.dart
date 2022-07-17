import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_resources.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: AppDimensions.aspectRatio3to2,
      child: Container(
        margin: const EdgeInsets.only(
          left: AppDimensions.margin16,
          right: AppDimensions.margin16,
          top: AppDimensions.margin16,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppDimensions.cornerRadius16,
            ),
          ),
          color: AppColors.cardColor,
        ),
        child: Column(
          children: [
            Expanded(child: _ImageCardWidget(sight: sight)),
            Expanded(child: _TextCardWidget(sight: sight)),
          ],
        ),
      ),
    );
  }
}

class _ImageCardWidget extends StatelessWidget {
  final Sight sight;

  const _ImageCardWidget({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: AppStrings.heroTagCard,
      child: SizedBox(
        child: Stack(fit: StackFit.expand, children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                AppDimensions.cornerRadius16,
              ),
              topRight: Radius.circular(
                AppDimensions.cornerRadius16,
              ),
            ),
            child: Image.network(
              sight.url,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : Center(
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
          Padding(
            padding: const EdgeInsets.all(AppDimensions.margin16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sight.type.toLowerCase(),
                  style: AppTypography.textText14Bold.copyWith(color: Colors.white),
                ),
                SvgPicture.asset(
                  AppAssets.heart,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _TextCardWidget extends StatelessWidget {
  final Sight sight;

  const _TextCardWidget({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const marginInsets = 16.0;

    return Padding(
      padding: const EdgeInsets.all(marginInsets),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sight.name,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.textText16Medium,
          ),
          Text(
            sight.details,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: AppTypography.textText14Regular.copyWith(
              color: AppColors.detailsCardColor,
            ),
          ),
        ],
      ),
    );
  }
}
