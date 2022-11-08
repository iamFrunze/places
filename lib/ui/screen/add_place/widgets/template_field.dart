import 'package:flutter/material.dart';
import 'package:places/res/app_dimensions.dart';

class TemplateField extends StatelessWidget {
  final String title;
  final Widget widget;

  const TemplateField({
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
