import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/favourite/favourite_settings.dart';
import 'package:places/ui/screen/favourite/widgets/drag_item.dart';
import 'package:places/ui/screen/favourite/widgets/draggable_builder_widget.dart';
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
  Widget build(BuildContext context) {
    return Consumer<FavouriteSettings>(builder: (context, model, child) {
      switch (model.currentStateVisited) {
        case ScreenState.success:
          return _Page(
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

class _Page extends StatelessWidget {
  final List<SightModel> sights;

  const _Page({Key? key, required this.sights}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FavouriteSettings>();
    final sightWidgets = sights
        .mapIndexed(
          (i, sight) => LongPressDraggable<SightModel>(
            key: ValueKey(i),
            data: sight,
            feedback: DragItem(
              sight: sight,
              parentWidth: MediaQuery.of(context).size.width,
            ),
            childWhenDragging: Container(),
            child: DragTarget<SightModel>(
              onAccept: (sight) => provider.onAcceptVisitedSights(sight, i),
              builder: (
                context,
                candidateData,
                rejectedData,
              ) {
                return DraggableBuilderWidget(
                  sight: sight,
                  card: _Card(sight: sight),
                  candidateData: candidateData,
                  onDismissed: (data) => provider.removeVisitedSight(sight),
                );
              },
            ),
          ),
        )
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: sightWidgets,
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final SightModel sight;

  const _Card({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FavouriteSettings>();
    final theme = Theme.of(context);

    return SightCard(
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
    );
  }
}
