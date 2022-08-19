import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/callback_state.dart';
import 'package:places/data/filter_model.dart';
import 'package:places/domain/filter_settings.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/filter/widgets/filter_custom_chip.dart';
import 'package:places/ui/widgets/appbar.dart';
import 'package:places/domain/app_settings.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FilterSettings>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<FilterSettings>(builder: (context, model, child) {
      return model.currentState == CallbackState.error
          ? Center(child: Text('Error'))
          : Scaffold(
              appBar: AppBarWidget(
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
                    onPressed: () => model.clearData(),
                    child: Text(
                      AppStrings.clear,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                  ),
                ],
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
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children: AppSettings.categories.map((category) {
                        final index = AppSettings.categories.indexOf(category);

                        return FilterCustomChip(
                          label: category.type,
                          icon: category.icon,
                          value: model.selectedCategories[index].value,
                          onChanged: (value) => model.selectSight(
                            index: index,
                            type: model.selectedCategories[index].type,
                            value: !value,
                          ),
                        );
                      }).toList(),
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
                      max: AppSettings.rangeEnd,
                      onChangeEnd: (value) =>
                          model.changeArea(start: value.start, end: value.end),
                      onChanged: (value) {
                        model.changeArea(start: value.start, end: value.end);
                      },
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      height: AppDimensions.elevatedBtnHeight,
                      width: AppDimensions.elevatedBtnWidth,
                      child: ElevatedButton(
                        onPressed: () async {
                          final filter = FilterModel(
                            category: model.selectedCategories
                                .map((e) => e.type)
                                .toList(),
                            rangeValues: model.rangeValue,
                          );
                          Navigator.of(context).pop(filter);
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
