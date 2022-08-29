import 'package:flutter/material.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/ui/sight_details/widgets/header/btn_on_back.dart';
import 'package:places/ui/sight_details/widgets/header/page_view_image.dart';
import 'package:places/ui/sight_details/widgets/header/page_view_indicator.dart';
import 'package:places/ui/sight_details/widgets/header/sliver_app_bar_delegate.dart';

class HeaderImageWidget extends StatelessWidget {
  final SightModel sight;

  const HeaderImageWidget({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return SliverPersistentHeader(
      delegate: SliverAppBarDelegate(
        maxHeight: 360,
        minHeight: 0,
        child: Stack(
          children: [
            PageViewImageWidget(
              sight: sight,
              pageController: pageController,
            ),
            PageViewIndicatorWidget(
              width: MediaQuery.of(context).size.width / 7,
            ),
            const BtnOnBackWidget(),
          ],
        ),
      ),
    );
  }
}
