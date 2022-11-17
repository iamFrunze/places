import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/filter_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/settings/constants.dart';
import 'package:places/ui/screen/filter/filter_settings.dart';
import 'package:places/ui/screen/filter/widgets/filter_custom_chip.dart';
import 'package:places/ui/widgets/appbar.dart';
import 'package:places/ui/widgets/error_page.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<FilterSettings>(builder: (context, model, child) {
      return model.currentState == ScreenState.error
          ? const ErrorPage()
          : Scaffold(
              appBar: _AppBar(
                onPressed: () => model.clearData(),
              ),
              body: Container(
                margin: const EdgeInsets.all(AppDimensions.margin16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.categories.toUpperCase(),
                      style:
                          theme.textTheme.bodySmall?.copyWith(fontSize: 12.0),
                    ),
                    const SizedBox(height: AppDimensions.margin32),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: model.categories.length,
                      itemBuilder: (context, index) {
                        final chip = model.categories[index];

                        return FilterCustomChip(
                          label: chip.type,
                          icon: chip.icon,
                          value: chip.value,
                          onChanged: (value) => model.selectSight(
                            type: chip.type,
                            value: !value,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppDimensions.margin48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.distance,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(fontSize: 16.0),
                        ),
                        Text(
                          '${AppStrings.from} ${model.rangeValue.start.toInt()} ${AppStrings.to} ${model.rangeValue.end.toInt()} ${AppStrings.km}',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(fontSize: 16.0),
                        ),
                      ],
                    ),
                    RangeSlider(
                      values: model.rangeValue,
                      max: Constants.rangeValueEnd,
                      onChangeEnd: (value) => model.changeArea(
                        start: value.start,
                        end: value.end,
                      ),
                      onChanged: (value) => model.changeArea(
                        start: value.start,
                        end: value.end,
                      ),
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      height: AppDimensions.elevatedBtnHeight,
                      width: AppDimensions.elevatedBtnWidth,
                      child: ElevatedButton(
                        onPressed: () async {
                          final filter = FilterModel(
                            category:
                                model.categories.map((e) => e.type).toList(),
                            rangeValues: model.rangeValue,
                          );
                          Navigator.of(context).pop<FilterModel>(filter);
                        },
                        child: Text(
                          AppStrings.show(model.countNearSights).toUpperCase(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const _AppBar({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      title: '',
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.margin12,
          ),
          child: SvgPicture.asset(
            AppAssets.back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            AppStrings.clear,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ),
        ),
      ],
    );
  }
}
