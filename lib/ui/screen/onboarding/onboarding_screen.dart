import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_strings.dart';
import 'package:places/ui/screen/nav_screen.dart';
import 'package:places/ui/screen/onboarding/onboarding_model.dart';
import 'package:places/ui/screen/onboarding/onboarding_settings.dart';
import 'package:provider/provider.dart';

final onBoarding = [
  OnBoardingModel(
    img: AppAssets.page1,
    title: AppStrings.title1,
    subtitle: AppStrings.subtitle1,
  ),
  OnBoardingModel(
    img: AppAssets.page2,
    title: AppStrings.title2,
    subtitle: AppStrings.subtitle2,
  ),
  OnBoardingModel(
    img: AppAssets.page3,
    title: AppStrings.title3,
    subtitle: AppStrings.subtitle3,
  ),
];

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onBoardingWidget = onBoarding
        .map((e) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(e.img),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 58,
                    top: 43,
                    right: 58,
                  ),
                  child: Text(
                    e.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 58,
                    top: 8,
                    right: 58,
                  ),
                  child: Text(
                    e.subtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ))
        .toList();

    final currentPage = context.watch<OnBoardingSettings>().currentPage;
    final isVisible = currentPage != onBoardingWidget.length - 1;

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: context.read<OnBoardingSettings>().onPageChange,
            children: onBoardingWidget,
          ),
          _PageViewIndicator(
            currentPage: currentPage,
          ),
          _SkipBtn(isVisible: isVisible),
          _OnStartBtn(isVisible: !isVisible),
        ],
      ),
    );
  }
}

class _SkipBtn extends StatelessWidget {
  final bool isVisible;

  const _SkipBtn({
    Key? key,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Positioned(
        right: 0,
        child: Container(
          margin: const EdgeInsets.only(
            top: AppDimensions.margin16,
            right: AppDimensions.margin16,
          ),
          child: TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<MainScreen>(
                builder: (context) => const MainScreen(),
              ),
              (route) => false,
            ),
            child: Text(
              AppStrings.skip,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
            ),
          ),
        ),
      ),
    );
  }
}

class _OnStartBtn extends StatelessWidget {
  final bool isVisible;

  const _OnStartBtn({
    Key? key,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Positioned(
        bottom: 1,
        left: 1,
        right: 1,
        child: Container(
          height: AppDimensions.elevatedBtnHeight,
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.margin16,
            vertical: AppDimensions.margin8,
          ),
          child: ElevatedButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<MainScreen>(
                builder: (context) => const MainScreen(),
              ),
              (route) => false,
            ),
            child: Text(AppStrings.onStart.toUpperCase()),
          ),
        ),
      ),
    );
  }
}

class _PageViewIndicator extends StatelessWidget {
  final int currentPage;

  const _PageViewIndicator({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 200,
      left: 1,
      right: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            child: Container(
              height: 8,
              width: currentPage == 0 ? 24 : 8,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppDimensions.cornerRadius8),
                ),
                color: currentPage == 0
                    ? Theme.of(context).colorScheme.tertiary
                    : AppColors.inactiveColorKit,
              ),
            ),
            duration: const Duration(seconds: 5),
          ),
          const SizedBox(width: 8),
          AnimatedContainer(
            child: Container(
              height: 8,
              width: currentPage == 1 ? 24 : 8,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppDimensions.cornerRadius8),
                ),
                color: currentPage == 1
                    ? Theme.of(context).colorScheme.tertiary
                    : AppColors.inactiveColorKit,
              ),
            ),
            duration: const Duration(seconds: 5),
          ),
          const SizedBox(width: 8),
          AnimatedContainer(
            child: Container(
              height: 8,
              width: currentPage == 2 ? 24 : 8,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppDimensions.cornerRadius8),
                ),
                color: currentPage == 2
                    ? Theme.of(context).colorScheme.tertiary
                    : AppColors.inactiveColorKit,
              ),
            ),
            duration: const Duration(seconds: 5),
          ),
        ],
      ),
    );
  }
}
