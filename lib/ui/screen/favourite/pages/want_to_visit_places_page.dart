import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/sight_card.dart';

class WantToVisitPage extends StatelessWidget {
  const WantToVisitPage({Key? key}) : super(key: key);

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
      child: Column(
        children: mocks
            .map(
              (sight) => SightCard(
                sight: sight,
                actions: const [
                  IconSvg(icon: AppAssets.calendar),
                  SizedBox(width: AppDimensions.margin16),
                  IconSvg(icon: AppAssets.close),
                ],
                details: [
                  Text(
                    sight.name,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.subtitle1,
                  ),
                  Text(
                    'Запланировано на 12 окт. 2020',
                    style: theme.textTheme.bodyText2?.copyWith(color: theme.colorScheme.tertiary),
                  ),
                  const SizedBox(height: AppDimensions.margin16),
                  Text(
                    'закрыто до 09:00',
                    style: theme.textTheme.bodyText2,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
