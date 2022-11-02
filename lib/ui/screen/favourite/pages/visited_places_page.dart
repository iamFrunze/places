import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/favourite/bloc/bloc_visited/visited_place_bloc.dart';
import 'package:places/ui/screen/favourite/widgets/draggable_builder_widget.dart';
import 'package:places/ui/widgets/empty_page.dart';
import 'package:places/ui/widgets/error_page.dart';
import 'package:places/ui/widgets/green_circle_progress_indicator.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/sight_card.dart';

class VisitedPlacesPage extends StatefulWidget {
  const VisitedPlacesPage({Key? key}) : super(key: key);

  @override
  State<VisitedPlacesPage> createState() => _VisitedPlacesPageState();
}

class _VisitedPlacesPageState extends State<VisitedPlacesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<VisitedPlaceBloc>(),
      builder: (_, state) {
        if (state is VisitedPlaceLoadingSuccessState) {
          return state.visitedPlaces.isNotEmpty
              ? _Page(places: state.visitedPlaces)
              : const EmptyPage(state: EmptyPageState.visitedSights);
        }
        if (state is VisitedPlaceLoadingFailureState) {
          const ErrorPage();
        }

        return const Center(child: GreenCircleProgressIndicator(size: 30));
      },
    );
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
    final places = widget.places
        .map((place) => DraggableBuilderWidget(
              card: _Card(place: place),
              onDismissed: (direction) => context
                  .read<VisitedPlaceBloc>()
                  .add(VisitedPlaceRemoveEvent(place: place)),
            ))
        .toList();

    return ReorderableListView(
      children: places,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = widget.places.removeAt(oldIndex);
          widget.places.insert(newIndex, item);
        });
      },
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
    final theme = Theme.of(context);

    return PlaceCard(
      place: place,
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
          onTap: () => context
              .read<VisitedPlaceBloc>()
              .add(VisitedPlaceRemoveEvent(place: place)),
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
