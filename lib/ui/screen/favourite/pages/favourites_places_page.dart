import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/favourite/favourite_settings.dart';
import 'package:places/ui/screen/favourite/widgets/drag_item.dart';
import 'package:places/ui/screen/favourite/widgets/draggable_builder_widget.dart';
import 'package:places/ui/widgets/empty_page.dart';
import 'package:places/ui/widgets/error_page.dart';
import 'package:places/ui/widgets/green_circle_progress_indicator.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:provider/provider.dart';

class WantToVisitPage extends StatefulWidget {
  const WantToVisitPage({Key? key}) : super(key: key);

  @override
  State<WantToVisitPage> createState() => _WantToVisitPageState();
}

class _WantToVisitPageState extends State<WantToVisitPage> {
  final streamController = StreamController<List<PlaceModel>>();

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  @override
  void initState() {
    super.initState();
    context.read<FavouriteSettings>().initFavouritePlaces().listen((event) {
      streamController.sink.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PlaceModel>>(
      stream: streamController.stream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: GreenCircleProgressIndicator(
              size: 30,
            ),
          );
        }

        if (snapshot.hasData) {
          return snapshot.data!.isNotEmpty
              ? _Page(place: snapshot.data!)
              : const EmptyPage(state: EmptyPageState.wantToVisitSights);
        }

        return const ErrorPage();
      },
    );
  }
}

class _Page extends StatelessWidget {
  final List<PlaceModel> place;

  const _Page({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FavouriteSettings>();
    final sightWidgets = place
        .mapIndexed(
          (i, place) => LongPressDraggable<PlaceModel>(
            key: UniqueKey(),
            data: place,
            feedback: DragItem(
              place: place,
              parentWidth: MediaQuery.of(context).size.width,
            ),
            childWhenDragging: Container(),
            child: DragTarget<PlaceModel>(
              onAccept: (sight) =>
                  provider.onAcceptDragFavouritePlace(place, i),
              builder: (
                context,
                candidateData,
                rejectedData,
              ) {
                return DraggableBuilderWidget(
                  card: _Card(place: place),
                  candidateData: candidateData,
                  onDismissed: (data) => provider
                      .removeFromFavouritesAt(i)
                      .catchError((Object e) =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          )),
                );
              },
            ),
          ),
        )
        .toList();

    return ListView.builder(
      itemCount: sightWidgets.length,
      itemBuilder: (context, index) => sightWidgets[index],
    );
  }
}

class _Card extends StatelessWidget {
  final PlaceModel place;

  const _Card({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FavouriteSettings>();
    final theme = Theme.of(context);

    return PlaceCard(
      place: place,
      actions: [
        InkWell(
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tap on calendar')),
          ),
          child: const IconSvg(icon: AppAssets.calendar),
        ),
        const SizedBox(width: AppDimensions.margin16),
        InkWell(
          onTap: () => provider.removeFromVisitingPlaces(place).catchError(
                (Object e) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                ),
              ),
          child: const IconSvg(icon: AppAssets.close),
        ),
      ],
      details: [
        Text(
          place.name,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall,
        ),
        Text(
          /// Непонятно
          'Запланировано на ',
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.tertiary),
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
