import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/category_model.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/add_place/add_place_widget_model.dart';
import 'package:places/ui/screen/add_place/widgets/categories.dart';
import 'package:places/ui/screen/add_place/widgets/coordinates.dart';
import 'package:places/ui/screen/add_place/widgets/create_btn.dart';
import 'package:places/ui/screen/add_place/widgets/description.dart';
import 'package:places/ui/screen/add_place/widgets/name_sight.dart';
import 'package:places/ui/screen/add_place/widgets/pictures.dart';
import 'package:places/ui/screen/add_place/widgets/show_on_map.dart';
import 'package:places/ui/widgets/appbar.dart';
import 'package:places/utils/routes/routes.dart';

class AddPlaceScreen extends CoreMwwmWidget<AddPlaceWM> {
  const AddPlaceScreen({
    Key? key,
    required WidgetModelBuilder<AddPlaceWM> widgetModelBuilder,
  }) : super(key: key, widgetModelBuilder: widgetModelBuilder);

  @override
  WidgetState<AddPlaceScreen, AddPlaceWM> createWidgetState() =>
      _AddPlaceScreenState();
}

class _AddPlaceScreenState extends WidgetState<AddPlaceScreen, AddPlaceWM> {
  final nameSightController = TextEditingController();
  final lonController = TextEditingController();
  final latController = TextEditingController();
  final descController = TextEditingController();

  final nameSightFN = FocusNode();
  final latFN = FocusNode();
  final lonFN = FocusNode();
  final descriptionFN = FocusNode();

  final createBtnFN = FocusNode();

  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const _AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.margin16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Pictures(
                removeImage: wm.removeImage,
                streamImages: wm.picturesStreamController.stream,
              ),
              CategoriesWidget(
                title: selectedCategory != null
                    ? selectedCategory!.type
                    : AppStrings.notSelected,
                onTap: () async {
                  final callback = await Navigator.pushNamed<CategoryModel>(
                    context,
                    Routes.toCategoriesList,
                  );
                  setState(() {
                    selectedCategory = callback;
                  });
                },
              ),
              const Divider(),
              NameSightFieldWidget(
                controller: nameSightController,
                focusNode: nameSightFN,
                onFieldSubmitted: (v) =>
                    fieldFocusChange(context, nameSightFN, latFN),
                onChanged: (value) {},
              ),
              CoordinatesFieldsWidget(
                latController: latController,
                lonController: lonController,
                latFN: latFN,
                lonFN: lonFN,
                onFieldSubmittedLat: (v) => fieldFocusChange(
                  context,
                  latFN,
                  lonFN,
                ),
                onFieldSubmittedLon: (v) => fieldFocusChange(
                  context,
                  lonFN,
                  descriptionFN,
                ),
                onChangedLat: (value) {},
                onChangedLon: (value) {},
              ),
              const ShowOnMapButtonWidget(),
              const SizedBox(height: 28),
              DescriptionFieldWidget(
                controller: descController,
                focusNode: descriptionFN,
                onFieldSubmitted: (v) =>
                    fieldFocusChange(context, descriptionFN, createBtnFN),
                onChanged: (value) {},
              ),
              const SizedBox(height: 28),
              CreateButtonWidget(
                focusNode: createBtnFN,
                onPressed: hasEmptyTextField()
                    ? null
                    : () => wm.addPlace().catchError((Object e) =>
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameSightController.dispose();
    latController.dispose();
    lonController.dispose();
    descController.dispose();
  }

  void fieldFocusChange(
    BuildContext context,
    FocusNode currentFocus,
    FocusNode nextFocus,
  ) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  bool hasEmptyTextField() =>
      nameSightController.text.isEmpty &&
      latController.text.isEmpty &&
      lonController.text.isEmpty &&
      descController.text.isEmpty;
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      leading: TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text(
          AppStrings.cancel,
          style: AppTypography.leadingText,
        ),
      ),
      title: AppStrings.newSight,
    );
  }
}
