import 'package:flutter/material.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/add_place/widgets/template_field.dart';
import 'package:places/ui/widgets/custom_text_form_field.dart';

class NameSightFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;

  const NameSightFieldWidget({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<NameSightFieldWidget> createState() => _NameSightFieldWidgetState();
}

class _NameSightFieldWidgetState extends State<NameSightFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TemplateField(
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
