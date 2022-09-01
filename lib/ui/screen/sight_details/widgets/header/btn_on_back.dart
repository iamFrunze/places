import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';

class BtnOnBackWidget extends StatelessWidget {
  const BtnOnBackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.iconBorderSize,
      width: AppDimensions.iconBorderSize,
      margin: const EdgeInsets.only(
        top: AppDimensions.margin32,
        left: AppDimensions.margin16,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(AppDimensions.cornerRadius10),
        ),
        color: Theme.of(context).primaryColor,
      ),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: SvgPicture.asset(
          AppAssets.back,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
