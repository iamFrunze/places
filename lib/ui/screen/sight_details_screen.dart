import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/app_resources.dart';

class SightDetailsScreen extends StatelessWidget {
  final Sight sight;

  const SightDetailsScreen({Key? key, required this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: AppStrings.heroTagCard,
                    child: Image.network(
                      sight.url,
                      loadingBuilder: (context, child, loadingProgress) {
                        return loadingProgress == null
                            ? child
                            : Container(
                                height: 400,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: AppDimensions.margin32,
                      left: AppDimensions.margin16,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(AppDimensions.cornerRadius10)),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      iconSize: 24,
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.margin16,
                  vertical: AppDimensions.margin24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sight.name,
                      style: AppTypography.textText24Bold,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          sight.type.toLowerCase(),
                          style: AppTypography.textText14Bold,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'закрыто до 09:00'.toLowerCase(),
                          style: AppTypography.textText14Regular.copyWith(
                            color: AppColors.workingHoursColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      sight.details,
                      style: AppTypography.textText14Regular,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 48,
                      width: double.maxFinite,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        label: const Text(
                          AppStrings.btnRoute,
                        ),
                        icon: SvgPicture.asset(AppAssets.route),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.cornerRadius12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: null,
                          style: TextButton.styleFrom(primary: Colors.black),
                          label: const Text(
                            AppStrings.plan,
                          ),
                          icon: SvgPicture.asset(AppAssets.calendar),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(primary: Colors.black),
                          label: const Text(
                            AppStrings.addToFavourite,
                          ),
                          icon: SvgPicture.asset(AppAssets.heart),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
