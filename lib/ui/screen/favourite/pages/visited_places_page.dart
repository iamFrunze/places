import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/sight_card.dart';

class VisitedPlacesPage extends StatelessWidget {
  const VisitedPlacesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Card();
  }
}

class _Card extends StatelessWidget {
  const _Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppDimensions.margin16),
        child: Column(
          children: mocks
              .map(
                (sight) => SightCard(
                  sight: sight,
                  actions: [
                    InkWell(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tap on calendar')),
                      ),
                      child: const IconSvg(
                        icon: AppAssets.calendar,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.margin16),
                    InkWell(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tap on close')),
                      ),
                      child: const IconSvg(icon: AppAssets.close),
                    ),
                  ],
                  details: [
                    Text(
                      sight.name,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall,
                    ),
                    Text(
                      'Цель достигнута 12 окт. 2020',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppDimensions.margin16),
                    Text(
                      'закрыто до 09:00',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
