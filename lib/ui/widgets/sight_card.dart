import 'package:flutter/material.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_typography.dart';

class SightCard extends StatelessWidget {
  final SightModel sight;
  final List<Widget> actions;
  final List<Widget> details;

  const SightCard({
    Key? key,
    required this.sight,
    required this.actions,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(top: AppDimensions.margin16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppDimensions.cornerRadius16,
          ),
        ),
        color: theme.colorScheme.surface,
      ),
      child: AspectRatio(
        aspectRatio: AppDimensions.aspectRatio3to2,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _ImageCardWidget(
                    sight: sight,
                  ),
                ),
                Expanded(
                  child: _TextCardWidget(
                    details: details,
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(AppDimensions.margin16)),
                  onTap: () {
                    debugPrint('card click');
                  },
                ),
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
                    style: AppTypography.bodyLarge.copyWith(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: actions,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageCardWidget extends StatelessWidget {
  final SightModel sight;

  const _ImageCardWidget({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(
            AppDimensions.cornerRadius16,
          ),
          topRight: Radius.circular(
            AppDimensions.cornerRadius16,
          ),
        ),
        // child: ImageLoader(
        //   imgUrl: sight.url,
        // ),
        child: Image.network(
          sight.url,
          fit: BoxFit.cover,
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
        ),
      ),
    );
  }
}

class _TextCardWidget extends StatelessWidget {
  final List<Widget> details;

  const _TextCardWidget({
    Key? key,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.margin16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: details,
      ),
    );
  }
}
