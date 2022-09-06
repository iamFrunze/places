import 'package:flutter/material.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/ui/screen/sight_details/sight_details_settings.dart';
import 'package:places/ui/screen/sight_details/widgets/body/body_text.dart';
import 'package:places/ui/screen/sight_details/widgets/body/sliver_subheader.dart';
import 'package:places/ui/screen/sight_details/widgets/header/header_image.dart';
import 'package:provider/provider.dart';

class SightDetailsScreen extends StatelessWidget {
  final int id;

  const SightDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sight = context.read<SightDetailsSettings>().fetchSight(id);

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
