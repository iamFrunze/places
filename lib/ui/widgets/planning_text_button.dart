import 'package:flutter/material.dart';
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
    final svgColors = Theme.of(context).extension<SvgPictureColors>()!;

    return TextButton.icon(
      onPressed: widget.onPressed,
      icon: IconSvg(
        icon: widget.icon,
        color: widget.onPressed != null
            ? svgColors.textBtnActiveColor!
            : svgColors.textBtnInactiveColor!,
      ),
      label: Text(widget.label),
    );
  }
}
