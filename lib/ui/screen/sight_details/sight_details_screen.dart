import 'package:flutter/material.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/sight_details/sight_details_settings.dart';
import 'package:places/ui/screen/sight_details/widgets/body/body_text.dart';
import 'package:places/ui/screen/sight_details/widgets/body/sliver_subheader.dart';
import 'package:places/ui/screen/sight_details/widgets/header/header_image.dart';
import 'package:provider/provider.dart';

class SightDetailsScreen extends StatefulWidget {
  final int id;

  const SightDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<SightDetailsScreen> createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final sight = context.read<SightDetailsSettings>().fetchSight(widget.id);

    return DraggableScrollableSheet(
      maxChildSize: 0.9,
      initialChildSize: 0.7,
      builder: (_, scrollController) => DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.cornerRadius16),
            topRight: Radius.circular(AppDimensions.cornerRadius16),
          ),
        ),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            HeaderImageWidget(sight: sight),
            SliverSubHeader(sight: sight),
            BodyTextWidget(sight: sight),
          ],
        ),
      ),
    );
  }
}
