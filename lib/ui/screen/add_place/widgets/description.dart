import 'package:flutter/material.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/add_place/widgets/template_field.dart';
import 'package:places/ui/widgets/custom_text_form_field.dart';

class DescriptionFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;

  const DescriptionFieldWidget({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DescriptionFieldWidget> createState() => _DescriptionFieldWidgetState();
}

class _DescriptionFieldWidgetState extends State<DescriptionFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TemplateField(
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
