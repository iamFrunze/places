import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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