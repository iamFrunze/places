import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/sight_card.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cards = mocks
        .map(
          (sight) => SightCard(
            sight: sight,
            actions: [
              InkWell(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tap on heart')),
                ),
                child: const IconSvg(icon: AppAssets.heart),
              ),
            ],
            details: [
              Text(
                sight.name,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall,
              ),
              Text(
                sight.details,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        )
        .toList();

    return Scaffold(
      appBar: _AppBarWidget(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppDimensions.margin16),
          child: Column(
            children: cards,
          ),
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + AppDimensions.margin64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      centerTitle: false,
      elevation: 0,
      title: Container(
        margin: const EdgeInsets.only(
          left: AppDimensions.margin16,
          right: AppDimensions.margin16,
        ),
        child: Text(
          AppStrings.interestingPlaces,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
