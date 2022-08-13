import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/domain/search_settings.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/list/sight_details_screen.dart';
import 'package:places/ui/screen/sight_search/widgets/history_list_tile.dart';
import 'package:places/ui/screen/sight_search/widgets/search_list_tile.dart';
import 'package:places/ui/widgets/appbar.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SearchSettings>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(
        controller: Provider.of<SearchSettings>(context).searchController,
      ),
      body: Consumer<SearchSettings>(
        builder: (context, model, child) {
          switch (model.currentState) {
            case CallbackState.success:
              return _Body(
                sights: model.foundSights,
              );
            case CallbackState.history:
              return _BodyHistory(
                history: model.historySights,
              );
            case CallbackState.error:
              return const Center(
                child: Text('Error'),
              );
            case CallbackState.empty:
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
        kToolbarHeight + AppDimensions.searchBarHeight60,
      );

  const _AppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      title: AppStrings.interestingPlaces,
      bottomWidget: SearchBarWidget(
        onTapSuffix: () => Provider.of<SearchSettings>(context, listen: false)
            .clearSearchBar(),
        onChanged: (value) {
          if (value.contains(' ')) {
            Provider.of<SearchSettings>(context, listen: false)
                .fetchSight(text: value);
          }
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).unfocus();
          Provider.of<SearchSettings>(context, listen: false)
              .fetchSight(text: value);
        },
        controller: controller,
        suffixIcon: Theme.of(context).brightness == Brightness.light
            ? AppAssets.clearWhite
            : AppAssets.clearDark,
      ),
    );
  }
}

class _BodyHistory extends StatefulWidget {
  final List<String> history;

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
    final tiles = widget.history
        .map(
          (e) => HistoryListTile(
            title: e,
            onClearTap: () =>
                Provider.of<SearchSettings>(context, listen: false)
                    .removeSightFromHistory(e),
            onTap: () => Provider.of<SearchSettings>(context, listen: false)
                .searchController
                .text = e,
          ),
        )
        .toList();

    return Container(
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
            shrinkWrap: true,
            itemBuilder: (context, index) => tiles[index],
            separatorBuilder: (context, index) => const Divider(),
            itemCount: tiles.length,
          ),
          const SizedBox(
            height: AppDimensions.margin16,
          ),
          TextButton(
            onPressed: () => Provider.of<SearchSettings>(context, listen: false)
                .clearHistory(),
            child: Text(
              AppStrings.clearHistory,
              style: AppTypography.textMedium16.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final List<SightModel> sights;

  const _Body({
    Key? key,
    required this.sights,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    final tiles = widget.sights
        .map(
          (e) => SearchListTileWidget(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<SightDetailsScreen>(
                builder: (context) => SightDetailsScreen(
                  sight: e,
                ),
              ),
            ),
            url: e.url,
            title: e.name,
            subtitle: e.type,
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
