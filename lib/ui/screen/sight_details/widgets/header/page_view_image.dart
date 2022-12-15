import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/sight_details/sight_details_settings.dart';
import 'package:provider/provider.dart';

class PageViewImageWidget extends StatelessWidget {
  final PlaceModel place;
  final PageController pageController;

  const PageViewImageWidget({
    Key? key,
    required this.place,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppDimensions.cornerRadius16),
        topRight: Radius.circular(AppDimensions.cornerRadius16),
      ),
      child: PageView.builder(
        controller: pageController,
        itemCount: place.urls.length,
        onPageChanged: context.read<SightDetailsSettings>().onPageChange,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: place.urls[index],
            placeholder: (ctx, url) => ColoredBox(
              color: AppColors.placeholderCardBackground,
              child: Hero(
                tag: 'card${place.id}',
                child: SvgPicture.asset(
                  AppAssets.placeholder,
                  fit: BoxFit.none,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
