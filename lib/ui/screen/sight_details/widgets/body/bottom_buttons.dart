import 'package:flutter/material.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/widgets/planning_text_button.dart';

class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PlanningTextButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tap on plan')),
          ),
          icon: AppAssets.calendar,
          label: AppStrings.plan,
        ),
        PlanningTextButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tap on favourite')),
          ),
          icon: AppAssets.heart,
          label: AppStrings.addToFavourite,
        ),
      ],
    );
  }
}
