import 'package:flutter/material.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/sight_details/sight_details_settings.dart';
import 'package:places/ui/widgets/planning_text_button.dart';
import 'package:provider/provider.dart';

class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentSight = context.watch<SightDetailsSettings>().currentSight;
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PlanningTextButton(
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              builder: (context, child) => Theme(
                data: Theme.of(context).copyWith(
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                  ),
                ),
                child: child!,
              ),
            );
            if (date != null) {
              await Future<void>.microtask(
                () => context
                    .read<SightDetailsSettings>()
                    .updatePlanningDateSight(date),
              );
            }
          },
          icon: currentSight?.planningDate != null
              ? AppAssets.calendarFill
              : AppAssets.calendar,
          color: currentSight?.planningDate != null
              ? theme.colorScheme.tertiary
              : theme.colorScheme.secondary,
          label: currentSight?.planningDate ?? AppStrings.plan,
          labelStyle: currentSight?.planningDate != null
              ? theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.tertiary)
              : theme.textTheme.bodyMedium,
        ),
        PlanningTextButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tap on favourite')),
          ),
          color: theme.colorScheme.secondary,
          icon: AppAssets.heart,
          label: AppStrings.addToFavourite,
          labelStyle: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
