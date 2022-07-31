import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/category.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/category/widgets/chips.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final labels = [
    Category(label: AppStrings.hotel, icon: AppAssets.hotel),
    Category(label: AppStrings.restaurant, icon: AppAssets.restaurant),
    Category(label: AppStrings.specialPlace, icon: AppAssets.specialPlace),
    Category(label: AppStrings.park, icon: AppAssets.park),
    Category(label: AppStrings.museum, icon: AppAssets.museum),
    Category(label: AppStrings.cafe, icon: AppAssets.cafe),
  ];

  RangeValues sliderValue = const RangeValues(0.0, 100.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: _AppBarWidget(
        onTapClear: () => setState(() {
          labels.map((e) => e.value = false).toList();
        }),
      ),
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
              children: labels.map((category) {
                final index = labels.indexOf(category);

                return CustomChip(
                  label: category.label,
                  icon: category.icon,
                  value: labels[index].value,
                  onChanged: (value) => setState(() {
                    labels[index].value = !value;
                  }),
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
                  '${AppStrings.from} ${sliderValue.start.toInt()} ${AppStrings.to} ${sliderValue.end.toInt()} ${AppStrings.km}',
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 16.0),
                ),
              ],
            ),
            RangeSlider(
              values: sliderValue,
              max: 100,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
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
                  AppStrings.show(40).toUpperCase(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTapClear;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const _AppBarWidget({required this.onTapClear});

  @override
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
