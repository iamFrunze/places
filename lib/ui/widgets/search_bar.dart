import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';

class SearchBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapSuffix;
  final String suffixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool readOnly;

  @override
  Size get preferredSize => const Size.fromHeight(
        AppDimensions.searchBarHeight50,
      );

  const SearchBarWidget({
    Key? key,
    required this.suffixIcon,
    this.controller,
    this.onTap,
    this.onTapSuffix,
    this.onChanged,
    this.onFieldSubmitted,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  OutlineInputBorder get border => const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimensions.cornerRadius12),
        ),
        borderSide: BorderSide(style: BorderStyle.none),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.margin16,
      ),
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        autofocus: true,
        readOnly: widget.readOnly,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        onTap: widget.onTap,
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        style: AppTypography.textMedium16
            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: AppStrings.search,
          hintStyle: TextStyle(
            color: AppColors.inactiveColorKit.withOpacity(0.56),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: border,
          enabledBorder: border,
          disabledBorder: border,
          focusedBorder: border,
          focusedErrorBorder: border,
          errorBorder: border,
          suffixIcon: InkWell(
            onTap: widget.onTapSuffix,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.margin16,
              ),
              child: SvgPicture.asset(widget.suffixIcon),
            ),
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppDimensions.margin16,
            ),
            child: SvgPicture.asset(AppAssets.search),
          ),
        ),
      ),
    );
  }
}
