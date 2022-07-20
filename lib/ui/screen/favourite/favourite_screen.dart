import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _AppBarWidget(),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppDimensions.margin16),
              decoration: BoxDecoration(
                color: AppColors.unselectedTabColor,
                borderRadius: BorderRadius.circular(AppDimensions.cornerRadius40),
              ),
              child: TabBar(
                labelStyle: AppTypography.textText14Bold,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.cornerRadius40),
                  color: AppColors.selectedTabColor,
                ),
                unselectedLabelColor: Colors.black.withOpacity(0.44),
                tabs: _tabs,
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  WantToVisitPage(),
                  VisitedPlacesPage(),
                ],
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
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        AppStrings.favourite,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
