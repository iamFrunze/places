import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactors/place_interactor_impl.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/favourite/bloc/bloc_favourite/favourite_place_bloc.dart';
import 'package:places/ui/screen/favourite/bloc/bloc_visited/visited_place_bloc.dart';
import 'package:places/ui/screen/favourite/pages/favourites_places_page.dart';
import 'package:places/ui/screen/favourite/pages/visited_places_page.dart';
import 'package:places/ui/widgets/appbar.dart';

const _tabBarHeight = 52.0;

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late final FavouritePlaceBloc _favouritePlaceBloc;
  late final VisitedPlaceBloc _visitedPlaceBloc;

  @override
  void initState() {
    super.initState();
    _favouritePlaceBloc =
        FavouritePlaceBloc(context.read<PlaceInteractorImpl>());
    _favouritePlaceBloc.add(FavouritePlaceInitEvent());
    _visitedPlaceBloc = VisitedPlaceBloc(context.read<PlaceInteractorImpl>());
    _visitedPlaceBloc.add(VisitedPlaceInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(AppDimensions.margin16),
          child: TabBarView(
            children: [
              BlocProvider(
                create: (context) => _favouritePlaceBloc,
                child: const WantToVisitPage(),
              ),
              BlocProvider(
                create: (context) => _visitedPlaceBloc,
                child: const VisitedPlacesPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final _tabs = [
    const Tab(
      text: AppStrings.wantToVisit,
    ),
    const Tab(
      text: AppStrings.visited,
    ),
  ];

  @override
  Size get preferredSize =>
      const Size.fromHeight(_tabBarHeight + kToolbarHeight);

  _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBarWidget(
      title: AppStrings.favourite,
      bottomWidget: PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.margin16,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppDimensions.cornerRadius40),
          ),
          child: TabBar(
            splashBorderRadius: const BorderRadius.all(
              Radius.circular(AppDimensions.cornerRadius40),
            ),
            tabs: _tabs,
          ),
        ),
      ),
    );
  }
}
