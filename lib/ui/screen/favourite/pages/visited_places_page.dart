import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/favourite/favourite_settings.dart';
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
    Future.microtask(
      () => context.read<FavouriteSettings>().initVisitingPlaces(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteSettings>(builder: (_, response, __) {
      return response.visitingPlaces.isEmpty
          ? const EmptyPage(state: EmptyPageState.visitedSights)
          : _Page(places: response.visitingPlaces);
    });
  }
}

class _Page extends StatefulWidget {
  final List<PlaceModel> places;

  const _Page({Key? key, required this.places}) : super(key: key);

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    final placesWidget = widget.places
        .map(
          (place) => _Card(place: place),
        )
        .toList();

    return ReorderableListView(
      children: placesWidget,
      onReorder: context.read<FavouriteSettings>().reorderVisitingItems,
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
          onTap: () async {
            /// Sharing
          },
          child: const IconSvg(
            icon: AppAssets.calendar,
          ),
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
