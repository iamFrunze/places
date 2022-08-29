import 'package:flutter/material.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/ui/sight_details/widgets/body/body_text.dart';
import 'package:places/ui/sight_details/widgets/body/sliver_subheader.dart';
import 'package:places/ui/sight_details/widgets/header/header_image.dart';

class SightDetailsScreen extends StatelessWidget {
  final SightModel sight;

  const SightDetailsScreen({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HeaderImageWidget(sight: sight),
          SliverSubHeader(sight: sight),
          BodyTextWidget(sight: sight),
        ],
      ),
    );
  }
}
