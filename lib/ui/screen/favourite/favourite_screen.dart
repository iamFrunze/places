import 'package:flutter/material.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/favourite/pages/favourites_places_page.dart';
import 'package:places/ui/screen/favourite/pages/visited_places_page.dart';
import 'package:places/ui/widgets/appbar.dart';

const _tabBarHeight = 52.0;

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(AppDimensions.margin16),
          child: TabBarView(
            children: [
              WantToVisitPage(),
              VisitedPlacesPage(),
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
