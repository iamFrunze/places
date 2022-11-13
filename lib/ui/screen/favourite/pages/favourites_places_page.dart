import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/favourite/favourite_settings.dart';
import 'package:places/ui/screen/favourite/widgets/draggable_builder_widget.dart';
import 'package:places/ui/widgets/adaptiveCalendar.dart';
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
  @override
  void initState() {
    Future.microtask(
      () => context.read<FavouriteSettings>().initFavouritePlaces(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteSettings>(builder: (_, response, __) {
      return response.favouritesPlaces.isEmpty
          ? const EmptyPage(state: EmptyPageState.wantToVisitSights)
          : _Page(place: response.favouritesPlaces);
    });
  }
}

class _Page extends StatefulWidget {
  final List<PlaceModel> place;

  const _Page({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    final placesWidget = widget.place
        .map((place) => DraggableBuilderWidget(
              key: UniqueKey(),
              card: _Card(place: place),
              onDismissed: (direction) =>
                  context.read<FavouriteSettings>().removeFromFavourites(place),
            ))
        .toList();

    return ReorderableListView(
      children: placesWidget,
      onReorder: context.read<FavouriteSettings>().reorderFavoriteItems,
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
    DateTime? dateTime;
    final isLoading = context.watch<FavouriteSettings>().isLoadData;

    return PlaceCard(
      place: place,
      actions: [
        if (isLoading)
          const GreenCircleProgressIndicator(size: 15)
        else
          InkWell(
            onTap: () async {
              dateTime = await showAdaptiveDatePicker(context);
              if (dateTime != null) {
                await Future<void>.microtask(
                  () => context
                      .read<FavouriteSettings>()
                      .updatePlanningDateSight(dateTime!),
                );
              }
            },
            child: const IconSvg(icon: AppAssets.calendar),
          ),
        const SizedBox(width: AppDimensions.margin16),
        if (isLoading)
          const GreenCircleProgressIndicator(size: 15)
        else
          InkWell(
            onTap: () => provider.removeFromFavourites(place),
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
          dateTime != null ? 'Запланировано на $dateTime' : 'Незапланировано',
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
