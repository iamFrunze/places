import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_typography.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final int minLines;
  final TextInputType keyboardType;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.validator,
    this.maxLines,
    this.minLines = 1,
    this.keyboardType = TextInputType.text,
    this.autofocus = false,
    this.focusNode,
    this.onFieldSubmitted,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    final isValid = widget.controller.text.isEmpty
        ? AppColors.inactiveColorKit
        : Theme.of(context).colorScheme.tertiary.withOpacity(0.4);

    return TextFormField(
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      style: AppTypography.textMedium16
          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.cornerRadius8),
          ),
          borderSide: BorderSide(
            color: isValid,
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () => widget.controller.text = '',
            child: SvgPicture.asset(
              Theme.of(context).brightness != Brightness.dark
                  ? AppAssets.clearWhite
                  : AppAssets.clearDark,
            ),
          ),
        ),
      ),
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
    );
  }
}
