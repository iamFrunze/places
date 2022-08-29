import 'package:flutter/material.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/sight_details/widgets/header/sliver_app_bar_delegate.dart';

class SliverSubHeader extends StatelessWidget {
  final SightModel sight;

  const SliverSubHeader({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 95,
        maxHeight: 95,
        child: Container(
          color: theme.colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.margin16, vertical: AppDimensions.margin24),
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
            ],
          ),
        ),
      ),
    );
  }
}
