import 'package:flutter/material.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/favourite/pages/visited_places_page.dart';
import 'package:places/ui/screen/favourite/pages/want_to_visit_places_page.dart';

class FavouriteScreen extends StatelessWidget {
  final _tabs = [
    const Tab(
      text: AppStrings.wantToVisit,
    ),
    const Tab(
      text: AppStrings.visited,
    ),
  ];

  FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _AppBarWidget(),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.margin16,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(AppDimensions.cornerRadius40),
              ),
              child: TabBar(
                tabs: _tabs,
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: AppDimensions.margin16),
                child: TabBarView(
                  children: [
                    WantToVisitPage(),
                    VisitedPlacesPage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.favourite),
    );
  }
}
