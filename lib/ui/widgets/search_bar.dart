import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/sight_search/redux/actions.dart';
import 'package:places/ui/screen/sight_search/redux/search_state.dart';
import 'package:places/utils/routes/routes.dart';

class SearchBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final GestureTapCallback? onTap;
  final bool onTapClearSearchBar;
  final String suffixIcon;
  final controller = TextEditingController();
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final String request;

  @override
  Size get preferredSize => const Size.fromHeight(
        AppDimensions.searchBarHeight50,
      );

  SearchBarWidget({
    Key? key,
    required this.suffixIcon,
    this.onTap,
    required this.request,
    required this.onTapClearSearchBar,
    this.onChanged,
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
    widget.controller.text = widget.request;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.margin16,
      ),
      padding: const EdgeInsets.only(bottom: 16),
      child: StoreConnector<SearchState, ValueChanged<String>>(
        converter: (store) {
          return (text) => store.dispatch(FetchPlacesAction(request: text));
        },
        builder: (ctx, callback) {
          return TextFormField(
            autofocus: true,
            readOnly: widget.readOnly,
            onChanged: callback,
            onFieldSubmitted: callback,
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
              suffixIcon: StoreConnector<SearchState, VoidCallback>(
                converter: (store) {
                  return () {
                    widget.controller.text = '';

                    store.dispatch(ClearSearchBarAction());
                  };
                },
                builder: (context, callback) {
                  return InkWell(
                    onTap: widget.onTapClearSearchBar
                        ? callback
                        : () => Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamed(Routes.toFilters),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.margin16,
                      ),
                      child: SvgPicture.asset(widget.suffixIcon),
                    ),
                  );
                },
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.margin16,
                ),
                child: SvgPicture.asset(AppAssets.search),
              ),
            ),
          );
        },
      ),
    );
  }
}
