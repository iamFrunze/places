import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/mocks.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/res/app_typography.dart';
import 'package:places/ui/widgets/sight_card.dart';

class WantToVisitPage extends StatelessWidget {
  const WantToVisitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Card();
  }
}

class _Card extends StatelessWidget {
  const _Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: mocks
            .map(
              (sight) => SightCard(
                sight: sight,
                actions: [
                  SvgPicture.asset(
                    AppAssets.calendar,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: AppDimensions.margin16,
                  ),
                  SvgPicture.asset(
                    AppAssets.close,
                    color: Colors.white,
                  ),
                ],
                details: [
                  Text(
                    sight.name,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.textText16Medium,
                  ),
                  Text(
                    'Запланировано на 12 окт. 2020',
                    style: AppTypography.textText14Regular.copyWith(color: Colors.green),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'закрыто до 09:00',
                    style: AppTypography.textText14Regular.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
