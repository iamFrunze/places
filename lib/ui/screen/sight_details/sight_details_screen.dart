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
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<SightDetailsSettings>().fetchPlace(widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final place = context.watch<SightDetailsSettings>().place;

    return place != null
        ? DraggableScrollableSheet(
            maxChildSize: 0.9,
            initialChildSize: 0.9,
            minChildSize: 0.5,
            builder: (_, scrollController) => DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppDimensions.cornerRadius16),
                  topRight: Radius.circular(AppDimensions.cornerRadius16),
                ),
              ),
              child: CustomScrollView(
                shrinkWrap: true,
                controller: scrollController,
                slivers: [
                  HeaderImageWidget(place: place),
                  SliverSubHeader(place: place),
                  BodyTextWidget(place: place),
                ],
              ),
            ),
          )
        : const Center(child: Text('Error fetch data'));
  }
}
