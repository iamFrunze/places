import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/screen/add_place/add_place_settings.dart';
import 'package:provider/provider.dart';

class CupertinoAddImage extends StatelessWidget {
  const CupertinoAddImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.margin16,
            vertical: AppDimensions.margin8,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.margin16,
            vertical: AppDimensions.margin8,
          ),
          decoration: const BoxDecoration(
            color: AppColors.lmWhiteColorKit,
            borderRadius:
                BorderRadius.all(Radius.circular(AppDimensions.cornerRadius16)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppAssets.camera),
                  TextButton(
                    onPressed: () => context
                        .read<AddPlaceSettings>()
                        .fetchPictureFromCamera(),
                    child: const Text(
                      AppStrings.camera,
                      style: AppTypography.cupertinoBottomSheet,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  SvgPicture.asset(AppAssets.picture),
                  TextButton(
                    onPressed: () => context
                        .read<AddPlaceSettings>()
                        .fetchPictureFromGallery(),
                    child: const Text(
                      AppStrings.picture,
                      style: AppTypography.cupertinoBottomSheet,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  SvgPicture.asset(AppAssets.file),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      AppStrings.file,
                      style: AppTypography.cupertinoBottomSheet,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.margin16,
            vertical: AppDimensions.margin8,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.margin16,
            vertical: AppDimensions.margin8,
          ),
          decoration: const BoxDecoration(
            color: AppColors.lmWhiteColorKit,
            borderRadius:
                BorderRadius.all(Radius.circular(AppDimensions.cornerRadius16)),
          ),
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              AppStrings.cancel.toUpperCase(),
              style: AppTypography.cupertinoBottomSheet
                  .copyWith(color: AppColors.lmGreenColorKit),
            ),
          ),
        ),
      ],
    );
  }
}
