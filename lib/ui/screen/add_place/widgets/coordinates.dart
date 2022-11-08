import 'package:flutter/material.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/add_place/widgets/template_field.dart';
import 'package:places/ui/widgets/custom_text_form_field.dart';

class CoordinatesFieldsWidget extends StatefulWidget {
  final TextEditingController lonController;
  final TextEditingController latController;

  final FocusNode lonFN;
  final FocusNode latFN;

  final ValueChanged<String>? onFieldSubmittedLon;
  final ValueChanged<String>? onFieldSubmittedLat;
  final ValueChanged<String>? onChangedLon;
  final ValueChanged<String>? onChangedLat;

  const CoordinatesFieldsWidget({
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
  State<CoordinatesFieldsWidget> createState() =>
      _CoordinatesFieldsWidgetState();
}

class _CoordinatesFieldsWidgetState extends State<CoordinatesFieldsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TemplateField(
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
          child: TemplateField(
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
