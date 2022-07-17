import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/widgets/sight_card.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    final cards = mocks
        .map(
          (sight) => SightCard(
            sight: sight,
            actions: [
              SvgPicture.asset(
                AppAssets.heart,
                color: Colors.white,
              ),
            ],
            details: [
              Text(
                sight.name,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.textText16Medium,
              ),
              Text(
                sight.details,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: AppTypography.textText14Regular.copyWith(
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _AppBarWidget(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
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
      flexibleSpace: Container(
        margin: const EdgeInsets.only(
          left: AppDimensions.margin16,
          right: AppDimensions.margin16,
          top: AppDimensions.margin64,
        ),
        child: const Text(
          AppStrings.interestingPlaces,
          textAlign: TextAlign.start,
          style: AppTypography.textText32Bold,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
