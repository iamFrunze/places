import 'package:flutter/material.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/sight_details/widgets/header/sliver_app_bar_delegate.dart';

class SliverSubHeader extends StatelessWidget {
  final PlaceModel place;

  const SliverSubHeader({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 90,
        maxHeight: 90,
        child: Container(
          color: theme.colorScheme.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.margin16,
            vertical: AppDimensions.margin16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                place.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    place.placeType.toLowerCase(),
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'закрыто до 09:00'.toLowerCase(),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
