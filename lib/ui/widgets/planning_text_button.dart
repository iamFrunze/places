import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/ui/widgets/icon_svg.dart';
import 'package:places/ui/widgets/svg_picture_colors.dart';

class PlanningTextButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String icon;
  final String label;

  const PlanningTextButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  State<PlanningTextButton> createState() => _PlanningTextButtonState();
}

class _PlanningTextButtonState extends State<PlanningTextButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return widget.onPressed != null
        ? TextButton.icon(
            onPressed: widget.onPressed,
            icon: IconSvg(
              icon: widget.icon,
              color: theme.extension<SvgPictureColors>()!.textBtnActiveColor.toColor(),
            ),
            label: Text(widget.label, style: theme.textTheme.bodyMedium),
          )
        : TextButton.icon(
            onPressed: null,
            icon: IconSvg(
              icon: widget.icon,
              color: theme.extension<SvgPictureColors>()!.textBtnInactiveColor.toColor(),
            ),
            label: Text(
              widget.label,
              style: theme.textTheme.bodyText1?.copyWith(
                color: AppColors.inactiveColorKit,
              ),
            ),
          );
  }
}
