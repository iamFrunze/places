import 'package:flutter/material.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';

class CreateButtonWidget extends StatefulWidget {
  final FocusNode focusNode;
  final VoidCallback? onPressed;

  const CreateButtonWidget({
    Key? key,
    required this.focusNode,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CreateButtonWidget> createState() => _CreateButtonWidgetState();
}

class _CreateButtonWidgetState extends State<CreateButtonWidget> {
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
