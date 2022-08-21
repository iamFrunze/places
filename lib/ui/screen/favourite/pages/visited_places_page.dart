import 'package:flutter/material.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/ui/screen/favourite/favourite_settings.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/widgets/empty_page.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:provider/provider.dart';

class VisitedPlacesPage extends StatefulWidget {
  const VisitedPlacesPage({Key? key}) : super(key: key);

  @override
  State<VisitedPlacesPage> createState() => _VisitedPlacesPageState();
}

class _VisitedPlacesPageState extends State<VisitedPlacesPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<FavouriteSettings>(context, listen: false).initVisitedData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteSettings>(builder: (context, model, child) {
      switch (model.currentState) {
        case ScreenState.success:
          return _Card(
            sights: model.visitedSights,
          );
        case ScreenState.loading:
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        case ScreenState.empty:
          return const EmptyPage(state: EmptyPageState.visitedSights);
        default:
          return const Center(
            child: Text('Error screen'),
          );
      }
    });
  }
}

class _Card extends StatelessWidget {
  final List<SightModel> sights;

  const _Card({Key? key, required this.sights}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = Provider.of<FavouriteSettings>(context, listen: false);

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppDimensions.margin16),
        child: Column(
          children: sights
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
                      onTap: () => provider.removeVisitedSight(sight),
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
