import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/filter_settings.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/add_sight/add_sight_screen.dart';
import 'package:places/ui/screen/filter/filter_screen.dart';
import 'package:places/ui/screen/sight_search/sight_search_screen.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/search_bar.dart';
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
                child: Ink(child: const IconSvg(icon: AppAssets.heart)),
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
                maxLines: 3,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        )
        .toList();

    return Scaffold(
      appBar: _AppBarWidget(),
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.margin16,
        ),
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            return cards[index];
          },
        ),
      ),
      floatingActionButton: const _FAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight +
            AppDimensions.margin64 +
            AppDimensions.searchBarHeight60,
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      elevation: 0,
      bottom: SearchBarWidget(
        readOnly: true,
        onTapSuffix: () => Navigator.push(
          context,
          MaterialPageRoute<FilterSettings>(
            builder: (context) => const FilterScreen(),
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<SightSearchScreen>(
            builder: (context) => const SightSearchScreen(),
          ),
        ),
        suffixIcon: AppAssets.filter,
      ),
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

class _FAB extends StatefulWidget {
  const _FAB({Key? key}) : super(key: key);

  @override
  State<_FAB> createState() => _FABState();
}

class _FABState extends State<_FAB> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.elevatedBtnHeight,
      width: 177,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        onPressed: () => Navigator.of(context).push<AddSightScreen>(
          MaterialPageRoute(
            builder: (context) => const AddSightScreen(),
          ),
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 177, minHeight: 48.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            gradient: LinearGradient(
              colors: <Color>[
                AppColors.btnLinearGradientStart,
                AppColors.btnLinearGradientEnd,
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(AppAssets.plus),
              Text(AppStrings.newSight.toUpperCase()),
            ],
          ),
        ),
      ),
    );
  }
}
