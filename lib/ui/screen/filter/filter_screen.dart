import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/category.dart';
import 'package:places/domain/filter_settings.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/filter/widgets/filter_custom_chip.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  static const _rangeValue = 10.0;

  final _labels = [
    Category(type: AppStrings.hotel, icon: AppAssets.hotel),
    Category(type: AppStrings.restaurant, icon: AppAssets.restaurant),
    Category(type: AppStrings.specialPlace, icon: AppAssets.specialPlace),
    Category(type: AppStrings.park, icon: AppAssets.park),
    Category(type: AppStrings.museum, icon: AppAssets.museum),
    Category(type: AppStrings.cafe, icon: AppAssets.cafe),
  ];

  RangeValues _sliderValue = const RangeValues(0.0, _rangeValue);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider(
      create: (context) => FilterSettings(),
      child: Consumer<FilterSettings>(builder: (context, model, child) {
        return Scaffold(
          appBar: _AppBarWidget(onTapClear: () async {
            setState(() {
              _labels.map((e) => e.value = false).toList();
              _sliderValue = const RangeValues(0.0, _rangeValue);
            });
            await model.clearData();
          }),
          body: Container(
            margin: const EdgeInsets.all(AppDimensions.margin16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.categories.toUpperCase(),
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 12.0),
                ),
                const SizedBox(
                  height: AppDimensions.margin32,
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: _labels.map((category) {
                    final index = _labels.indexOf(category);

                    return FilterCustomChip(
                      label: category.type,
                      icon: category.icon,
                      value: _labels[index].value,
                      onChanged: (value) async {
                        setState(() {
                          _labels[index].value = !value;
                        });
                        await model.selectSight(
                          index: index,
                          type: _labels[index].type,
                          value: _labels[index].value,
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: AppDimensions.margin48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.distance,
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16.0),
                    ),
                    Text(
                      '${AppStrings.from} ${_sliderValue.start.toInt()} ${AppStrings.to} ${_sliderValue.end.toInt()} ${AppStrings.km}',
                      style: theme.textTheme.bodySmall?.copyWith(fontSize: 16.0),
                    ),
                  ],
                ),
                RangeSlider(
                  values: _sliderValue,
                  max: _rangeValue,
                  onChangeEnd: (value) => model.changArea(
                    start: value.start,
                    end: value.end,
                  ),
                  onChanged: (value) async {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                ),
                Expanded(child: Container()),
                SizedBox(
                  height: AppDimensions.elevatedBtnHeight,
                  width: AppDimensions.elevatedBtnWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('tap on show'),
                        ),
                      );
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
      }),
    );
  }
}

class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTapClear;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const _AppBarWidget({required this.onTapClear});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppDimensions.margin16),
        height: preferredSize.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: SvgPicture.asset(
                AppAssets.back,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            TextButton(
              onPressed: onTapClear,
              child: Text(
                AppStrings.clear,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
