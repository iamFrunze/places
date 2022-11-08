import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/add_place/widgets/template_field.dart';

class CategoriesWidget extends StatefulWidget {
  final GestureTapCallback? onTap;
  final String title;

  const CategoriesWidget({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  State<CategoriesWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return TemplateField(
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
