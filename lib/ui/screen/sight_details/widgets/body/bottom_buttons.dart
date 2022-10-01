import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    final planningDate = context.watch<SightDetailsSettings>().planningDate;
    final isFavourite = context.watch<SightDetailsSettings>().isFavourite;
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PlanningTextButton(
          onPressed: () async {
            final date = await showAdaptiveDatePicker(context);
            if (date != null) {
              await Future<void>.microtask(
                () => context
                    .read<SightDetailsSettings>()
                    .updatePlanningDateSight(date),
              );
            }
          },
          icon: planningDate != null
              ? AppAssets.calendarFill
              : AppAssets.calendar,
          color: planningDate != null
              ? theme.colorScheme.tertiary
              : theme.colorScheme.secondary,
          label: planningDate ?? AppStrings.plan,
          labelStyle: planningDate != null
              ? theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.tertiary)
              : theme.textTheme.bodyMedium,
        ),
        PlanningTextButton(
          onPressed: () =>
              context.read<SightDetailsSettings>().addToFavourite(),
          color: theme.colorScheme.secondary,
          icon: context.watch<SightDetailsSettings>().isFavourite
              ? AppAssets.heartFill
              : AppAssets.heart,
          label: AppStrings.addToFavourite,
          labelStyle: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Future<DateTime?> showAdaptiveDatePicker(BuildContext context) async {
    DateTime? selectDate;
    if (Platform.isAndroid) {
      selectDate = await showDatePicker(
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
    }
    if (Platform.isIOS) {
      await showCupertinoModalPopup<CupertinoDatePicker>(
        context: context,
        builder: (context) {
          return Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                onDateTimeChanged: (newDate) {
                  selectDate = newDate;
                },
              ),
            ),
          );
        },
      );
    }

    return selectDate;
  }
}
