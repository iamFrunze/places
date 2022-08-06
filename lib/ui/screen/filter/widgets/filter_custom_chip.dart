import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';

class FilterCustomChip extends StatefulWidget {
  final String label;
  final String icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const FilterCustomChip({
    Key? key,
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FilterCustomChip> createState() => _FilterCustomChipState();
}

class _FilterCustomChipState extends State<FilterCustomChip> {
  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    final onChanged = widget.onChanged;
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onChanged(value),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: AppDimensions.chipSize,
                width: AppDimensions.chipSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.tertiary.withOpacity(0.16),
                ),
                child: SvgPicture.asset(
                  widget.icon,
                  fit: BoxFit.scaleDown,
                ),
              ),
              if (value)
                SizedBox(
                  height: AppDimensions.iconSize,
                  width: AppDimensions.iconSize,
                  child: SvgPicture.asset(
                    theme.brightness != Brightness.light
                        ? AppAssets.choiceWhite
                        : AppAssets.choiceBlack,
                  ),
                )
              else
                const SizedBox(
                  height: AppDimensions.iconSize,
                  width: AppDimensions.iconSize,
                ),
            ],
          ),
          const SizedBox(
            height: AppDimensions.margin12,
          ),
          Text(
            widget.label,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
