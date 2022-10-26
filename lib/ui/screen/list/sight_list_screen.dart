import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/list/sight_list_settings.dart';
import 'package:places/ui/widgets/error_page.dart';
import 'package:places/ui/widgets/green_circle_progress_indicator.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/utils/routes/routes.dart';
import 'package:provider/provider.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  final streamController = StreamController<List<PlaceModel>>();
  final scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    streamController.close();
    scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<SightListSettings>().fetchData().listen((event) {
      streamController.sink.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<PlaceModel>>(
          stream: streamController.stream,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              final cards = snapshot.data!
                  .map(
                    (place) => Padding(
                      padding: const EdgeInsets.only(
                        top: AppDimensions.margin16,
                        left: AppDimensions.margin16,
                        right: AppDimensions.margin16,
                      ),
                      child: PlaceCard(
                        place: place,
                        actions: [
                          InkWell(
                            onTap: () => context
                                .read<SightListSettings>()
                                .addToFavourite(place),
                            child: context
                                    .watch<SightListSettings>()
                                    .isFavourite(place)
                                ? Ink(
                                    child: const IconSvg(
                                      icon: AppAssets.heartFill,
                                    ),
                                  )
                                : Ink(
                                    child: const IconSvg(
                                      icon: AppAssets.heart,
                                    ),
                                  ),
                          ),
                        ],
                        details: [
                          Text(
                            place.name,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleSmall,
                          ),
                          Text(
                            place.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList();

              return CustomScrollView(
                controller: scrollController,
                slivers: [
                  const _SliverAppBar(),
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => cards[index],
                      childCount: cards.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: AppDimensions.aspectRatio3to2,
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 1
                          : 2,
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return const Center(child: ErrorPage());
            }

            return const Center(
              child: GreenCircleProgressIndicator(
                size: 30,
              ),
            );
          },
        ),
      ),
      floatingActionButton: const _FAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  const _SliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      expandedHeight: kToolbarHeight +
          AppDimensions.margin64 +
          AppDimensions.searchBarHeight50,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 2,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(
          bottom: AppDimensions.searchBarHeight50 + 30,
          left: 16,
          right: 16,
        ),
        title: AutoSizeText(
          AppStrings.interestingPlaces,
          maxLines: 2,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      bottom: SearchBarWidget(
        readOnly: true,
        onTapSuffix: () => Navigator.of(
          context,
          rootNavigator: true,
        ).pushNamed(Routes.toFilters),
        onTap: () => Navigator.pushNamed(context, Routes.toSearch),
        suffixIcon: AppAssets.filter,
      ),
    );
  }
}

class _FAB extends StatefulWidget {
  const _FAB({Key? key}) : super(key: key);

  @override
  State<_FAB> createState() => _FABState();
}

class _FABState extends State<_FAB> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.elevatedBtnHeight,
      width: 177,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: () => Navigator.of(context, rootNavigator: true)
            .pushNamed(Routes.toAddSight),
        child: Container(
          constraints: const BoxConstraints(minWidth: 177, minHeight: 48.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            gradient: LinearGradient(
              colors: <Color>[
                AppColors.btnLinearGradientStart,
                AppColors.btnLinearGradientEnd,
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(AppAssets.plus),
              Text(AppStrings.newSight.toUpperCase()),
            ],
          ),
        ),
      ),
    );
  }
}
