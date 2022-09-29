import 'package:flutter/material.dart';
import 'package:places/data/model/place_model.dart';

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
          return Image.network(
            place.urls[index],
            loadingBuilder: (context, child, loadingProgress) {
              return loadingProgress == null
                  ? child
                  : Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
            },
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
