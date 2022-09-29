import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/sight_search/search_settings.dart';
import 'package:places/ui/screen/sight_search/widgets/history_list_tile.dart';
import 'package:places/ui/screen/sight_search/widgets/search_list_tile.dart';
import 'package:places/ui/widgets/appbar.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/utils/routes/routes.dart';
import 'package:provider/provider.dart';

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _AppBar(
        controller: Provider.of<SearchSettings>(context).searchController,
      ),
      body: Consumer<SearchSettings>(
        builder: (context, model, child) {
          switch (model.currentState) {
            case ScreenState.success:
              return _Body(places: model.foundSights);
            case ScreenState.history:
              return _BodyHistory(
                history: model.historySights,
              );
            case ScreenState.error:
              return const Center(
                child: Text('Error'),
              );
            case ScreenState.empty:
              return const _BodyEmptyList();
            default:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
          }
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight + AppDimensions.searchBarHeight50,
      );

  const _AppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SearchSettings>();

    return AppBarWidget(
      title: AppStrings.interestingPlaces,
      bottomWidget: SearchBarWidget(
        onTapSuffix: provider.clearSearchBar,
        onChanged: (value) async {
          if (value.contains(' ')) {
            await provider.fetchSight(text: value);
          }
        },
        onFieldSubmitted: (value) async {
          FocusScope.of(context).unfocus();
          await provider.fetchSight(text: value);
        },
        controller: controller,
        suffixIcon: Theme.of(context).brightness == Brightness.light
            ? AppAssets.clearDark
            : AppAssets.clearWhite,
      ),
    );
  }
}

class _BodyHistory extends StatefulWidget {
  final LinkedHashSet<String> history;

  const _BodyHistory({
    Key? key,
    required this.history,
  }) : super(key: key);

  @override
  State<_BodyHistory> createState() => _BodyHistoryState();
}

class _BodyHistoryState extends State<_BodyHistory> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<SearchSettings>();
    final scrollController = ScrollController();

    final tiles = widget.history
        .map(
          (e) => HistoryListTile(
            title: e,
            onClearTap: () => provider.removeSightFromHistory(e),
            onTap: () => provider.searchController.text = e,
          ),
        )
        .toList();

    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        margin: const EdgeInsets.only(
          top: AppDimensions.margin24,
          left: AppDimensions.margin16,
          right: AppDimensions.margin16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.youSearch.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.inactiveColorKit),
            ),
            const SizedBox(
              height: AppDimensions.margin16,
            ),
            ListView.separated(
              controller: scrollController,
              shrinkWrap: true,
              itemBuilder: (context, index) => tiles[index],
              separatorBuilder: (context, index) => const Divider(),
              itemCount: tiles.length,
            ),
            const SizedBox(
              height: AppDimensions.margin16,
            ),
            TextButton(
              onPressed: provider.clearHistory,
              child: Text(
                AppStrings.clearHistory,
                style: AppTypography.textMedium16.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final List<PlaceModel> places;

  const _Body({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    final tiles = widget.places
        .map(
          (e) => SearchListTileWidget(
            onTap: () => Navigator.pushNamed(
              context,
              Routes.toDetails,
              arguments: e,
            ),
            url: e.urls.first,
            title: e.name,
            subtitle: e.placeType,
          ),
        )
        .toList();

    return Container(
      margin: const EdgeInsets.only(top: AppDimensions.margin24),
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return tiles[index];
        },
        itemCount: tiles.length,
      ),
    );
  }
}

class _BodyEmptyList extends StatelessWidget {
  const _BodyEmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.search,
            height: 64,
            width: 64,
          ),
          const SizedBox(
            height: AppDimensions.margin24,
          ),
          Text(
            AppStrings.notFound,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: AppDimensions.margin6,
          ),
          Text(
            AppStrings.tryChangeSearchParams,
            style: AppTypography.bodyMedium
                .copyWith(color: AppColors.inactiveColorKit),
          ),
        ],
      ),
    );
  }
}
