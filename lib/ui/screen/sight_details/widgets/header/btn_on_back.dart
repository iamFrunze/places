import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_dimensions.dart';

class BtnOnBackWidget extends StatelessWidget {
  const BtnOnBackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 1,
      child: Container(
        height: AppDimensions.iconCloseSize,
        width: AppDimensions.iconCloseSize,
        margin: const EdgeInsets.only(
          top: AppDimensions.margin32,
          right: AppDimensions.margin16,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(
            AppAssets.close,
            fit: BoxFit.none,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
