import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';
import 'package:places/res/app_dimensions.dart';
import 'package:places/ui/screen/favourite/widgets/dismissible_card.dart';

/// Widget для формирования builder у LongPressDraggable
class DraggableBuilderWidget extends StatelessWidget {
  final Widget card;
  final DismissDirectionCallback onDismissed;

  const DraggableBuilderWidget({
    Key? key,
    required this.card,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CardCustomizer(
      card: card,
      onDismissed: onDismissed,
    );
  }
}

/// Widget, чтобы спрятать острые углы у карточки при свайпе
class _CardCustomizer extends StatelessWidget {
  final Widget card;
  final DismissDirectionCallback onDismissed;

  const _CardCustomizer({
    Key? key,
    required this.card,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.margin16),
      child: AspectRatio(
        aspectRatio: AppDimensions.aspectRatio3to2,
        child: Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.lmRedColorKit
                    : AppColors.dmRedColorKit,
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppDimensions.cornerRadius16),
                ),
              ),
              child: Container(),
            ),
            DismissibleCardWidget(
              card: card,
              onDismissed: onDismissed,
            ),
          ],
        ),
      ),
    );
  }
}
