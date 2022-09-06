import 'package:flutter/material.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/sight_details/sight_details_settings.dart';
import 'package:provider/provider.dart';

class PageViewImageWidget extends StatelessWidget {
  final SightModel sight;
  final PageController pageController;

  const PageViewImageWidget({
    Key? key,
    required this.sight,
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
        itemCount: 7,
        onPageChanged: context.read<SightDetailsSettings>().onPageChange,
        itemBuilder: (context, index) {
          return Image.network(
            sight.url,
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
