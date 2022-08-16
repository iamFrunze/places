import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/category_model.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/widgets/appbar.dart';
import 'package:places/utils/app_settings.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final _categories = AppSettings.categories;
  bool isSelected = false;
  CategoryModel? _selectCategory;

  @override
  void initState() {
    super.initState();
    _categories.map((e) => e.value = false).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset(AppAssets.back),
        ),
        title: AppStrings.category,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppDimensions.margin16),
        child: Column(children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _categories.map((e) => e.value = false).toList();
                      _categories[index].value = !_categories[index].value;
                      _selectCategory = _categories[index];
                    });
                  },
                  child: Ink(
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(_categories[index].type),
                          ),
                        ),
                        if (_categories[index].value)
                          Container(
                            margin: const EdgeInsets.only(
                              right: AppDimensions.margin16,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.tick,
                            ),
                          )
                        else
                          Container(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: AppDimensions.elevatedBtnHeight,
            width: AppDimensions.elevatedBtnWidth,
            margin: const EdgeInsets.only(bottom: 8),
            child: ElevatedButton(
              onPressed: _selectCategory != null ? saveCategory : null,
              child: Text(AppStrings.save.toUpperCase()),
            ),
          ),
        ]),
      ),
    );
  }

  void saveCategory() => Navigator.of(context).pop(_selectCategory);
}
