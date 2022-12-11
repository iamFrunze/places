import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/list/sight_list_settings.dart';
import 'package:places/ui/screen/map/map_settings.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<MapSettings>();
    final selectedPlace = context.watch<MapSettings>().selectedPlace;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.map),
        bottom: SearchBarWidget(
          readOnly: true,
          onTapSuffix: () => Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(Routes.toFilters),
          onTap: () => Navigator.pushNamed(context, Routes.toSearch),
          suffixIcon: AppAssets.filter,
        ),
      ),
      body: Stack(
        children: [
          YandexMap(
            mapObjects: context.watch<MapSettings>().objects,
            onMapCreated: (controller) async {
              await provider.setupController(controller);
              await provider.autoZoom();
              await provider.fetchFilteredData();
            },
          ),
          Positioned(
            bottom: 10,
            right: 10,
            left: 10,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        onPressed: provider.fetchFilteredData,
                        child: SvgPicture.asset(AppAssets.refresh),
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (selectedPlace == null)
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: AppDimensions.elevatedBtnHeight,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            onPressed: () =>
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(Routes.toAddSight),
                            child: Container(
                              constraints: const BoxConstraints(
                                minWidth: 177,
                                minHeight: 48.0,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24.0)),
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    AppColors.btnLinearGradientEnd,
                                    AppColors.btnLinearGradientStart,
                                  ],
                                  tileMode: TileMode.mirror,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(AppAssets.plus),
                                  Text(AppStrings.newSight.toUpperCase()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        onPressed: provider.autoZoom,
                        child: SvgPicture.asset(AppAssets.geolocation),
                      ),
                    ),
                  ],
                ),
                if (selectedPlace != null) _Card(placeModel: selectedPlace),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final PlaceModel placeModel;

  const _Card({
    Key? key,
    required this.placeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PlaceCard(
        place: placeModel,
        actions: [
          InkWell(
            onTap: () =>
                context.read<SightListSettings>().addToFavourite(placeModel),
            child: context.watch<SightListSettings>().isFavourite(placeModel)
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
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      placeModel.name,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall,
                    ),
                    Text(
                      placeModel.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 60,
                width: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    final isOpen =
                        await context.read<MapSettings>().openNativeMap();
                    if (!isOpen) {
                      await Future.microtask(
                        () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Установите Яндекс.карты'),
                          ),
                        ),
                      );
                    }
                  },
                  child: SvgPicture.asset(
                    AppAssets.go,
                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
