import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/category_model.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/add_sight/category_list_screen.dart';
import 'package:places/ui/widgets/appbar.dart';
import 'package:places/ui/widgets/custom_text_form_field.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
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
      appBar: AppBarWidget(
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            AppStrings.cancel,
            style: AppTypography.leadingText,
          ),
        ),
        title: AppStrings.newSight,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.margin16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CategoryWidget(
                title: selectedCategory != null
                    ? selectedCategory!.type
                    : AppStrings.notSelected,
                onTap: () async {
                  final callback =
                      await Navigator.of(context).push<CategoryModel>(
                    MaterialPageRoute(
                      builder: (context) => const CategoryListScreen(),
                    ),
                  );
                  setState(() {
                    selectedCategory = callback;
                  });
                },
              ),
              const Divider(),
              _NameSight(
                controller: nameSightController,
                focusNode: nameSightFN,
                onFieldSubmitted: (v) =>
                    fieldFocusChange(context, nameSightFN, latFN),
                onChanged: (value) {},
              ),
              _CoordinatesWidget(
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
              const _ShowOnMap(),
              const SizedBox(
                height: 28,
              ),
              _DescriptionWidget(
                controller: descController,
                focusNode: descriptionFN,
                onFieldSubmitted: (v) =>
                    fieldFocusChange(context, descriptionFN, createBtnFN),
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 28,
              ),
              _CreateButton(
                focusNode: createBtnFN,
                onPressed: hasEmptyTextField()
                    ? null
                    : () {
                        mocks.add(
                          SightModel(
                            name: nameSightController.text,
                            lat: double.parse(latController.text),
                            lon: double.parse(lonController.text),
                            url: '',
                            details: descController.text,
                            type: selectedCategory != null
                                ? selectedCategory!.type
                                : AppStrings.notSelected,
                          ),
                        );
                      },
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

class _CategoryWidget extends StatefulWidget {
  final GestureTapCallback? onTap;
  final String title;

  const _CategoryWidget({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  State<_CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<_CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return _TemplateWidget(
      title: AppStrings.category,
      widget: InkWell(
        onTap: widget.onTap,
        child: Ink(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: AppTypography.categoryFilter,
              ),
              SvgPicture.asset(AppAssets.view),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameSight extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;

  const _NameSight({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<_NameSight> createState() => _NameSightState();
}

class _NameSightState extends State<_NameSight> {
  @override
  Widget build(BuildContext context) {
    return _TemplateWidget(
      title: AppStrings.nameSight,
      widget: ValueListenableBuilder(
        valueListenable: widget.controller,
        builder: (context, value, __) {
          return CustomTextFormField(
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onChanged,
            controller: widget.controller,
            validator: (value) => value != null && value.isNotEmpty ? null : '',
          );
        },
      ),
    );
  }
}

class _CoordinatesWidget extends StatefulWidget {
  final TextEditingController lonController;
  final TextEditingController latController;

  final FocusNode lonFN;
  final FocusNode latFN;

  final ValueChanged<String>? onFieldSubmittedLon;
  final ValueChanged<String>? onFieldSubmittedLat;
  final ValueChanged<String>? onChangedLon;
  final ValueChanged<String>? onChangedLat;

  const _CoordinatesWidget({
    Key? key,
    required this.lonController,
    required this.latController,
    required this.lonFN,
    required this.latFN,
    required this.onFieldSubmittedLon,
    required this.onFieldSubmittedLat,
    required this.onChangedLon,
    required this.onChangedLat,
  }) : super(key: key);

  @override
  State<_CoordinatesWidget> createState() => _CoordinatesWidgetState();
}

class _CoordinatesWidgetState extends State<_CoordinatesWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _TemplateWidget(
            title: AppStrings.latitude,
            widget: ValueListenableBuilder(
              valueListenable: widget.latController,
              builder: (context, value, __) {
                return CustomTextFormField(
                  focusNode: widget.latFN,
                  onFieldSubmitted: widget.onFieldSubmittedLat,
                  onChanged: widget.onChangedLat,
                  controller: widget.latController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value != null && value.isNotEmpty ? null : '',
                );
              },
            ),
          ),
        ),
        const SizedBox(
          width: AppDimensions.margin16,
        ),
        Expanded(
          child: _TemplateWidget(
            title: AppStrings.longitude,
            widget: ValueListenableBuilder(
              valueListenable: widget.lonController,
              builder: (context, value, __) {
                return CustomTextFormField(
                  focusNode: widget.lonFN,
                  onFieldSubmitted: widget.onFieldSubmittedLon,
                  onChanged: widget.onChangedLon,
                  controller: widget.lonController,
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value != null && value.isNotEmpty ? null : '',
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ShowOnMap extends StatelessWidget {
  const _ShowOnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        AppStrings.showOnMap,
        style: AppTypography.textMedium16.copyWith(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}

class _DescriptionWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;

  const _DescriptionWidget({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<_DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<_DescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return _TemplateWidget(
      title: AppStrings.description,
      widget: ValueListenableBuilder(
        valueListenable: widget.controller,
        builder: (context, controller, __) {
          return Container(
            constraints: const BoxConstraints(
              maxHeight: 80,
            ),
            child: CustomTextFormField(
              focusNode: widget.focusNode,
              onFieldSubmitted: widget.onFieldSubmitted,
              onChanged: widget.onChanged,
              controller: widget.controller,
              minLines: 2,
              validator: (value) =>
                  value != null && value.isNotEmpty ? null : '',
            ),
          );
        },
      ),
    );
  }
}

class _CreateButton extends StatefulWidget {
  final FocusNode focusNode;
  final VoidCallback? onPressed;

  const _CreateButton({
    Key? key,
    required this.focusNode,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<_CreateButton> createState() => _CreateButtonState();
}

class _CreateButtonState extends State<_CreateButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.elevatedBtnWidth,
      height: AppDimensions.elevatedBtnHeight,
      child: ElevatedButton(
        focusNode: widget.focusNode,
        onPressed: widget.onPressed,
        child: Text(AppStrings.create.toUpperCase()),
      ),
    );
  }
}

class _TemplateWidget extends StatelessWidget {
  final String title;
  final Widget widget;

  const _TemplateWidget({
    Key? key,
    required this.title,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: AppDimensions.margin14,
            top: AppDimensions.margin24,
          ),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        widget,
      ],
    );
  }
}
