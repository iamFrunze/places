import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/widgets/appbar.dart';
import 'package:places/utils/app_settings.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppSettingsModel>(context, listen: true).isDarkMode;

    final theme = Theme.of(context);

    return Scaffold(
      appBar: const AppBarWidget(title: AppStrings.settings),
      body: Container(
        margin: const EdgeInsets.only(
          top: AppDimensions.margin48,
          left: AppDimensions.margin16,
          right: AppDimensions.margin16,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.darkTheme,
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16.0),
                ),
                CupertinoSwitch(
                  value: isDarkMode,
                  onChanged: (value) => Provider.of<AppSettingsModel>(context, listen: false)
                      .changeAppMode(value: value),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.tutorial,
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16.0),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(
                    AppAssets.info,
                    color: theme.colorScheme.tertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
