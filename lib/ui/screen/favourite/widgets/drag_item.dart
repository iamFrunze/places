import 'package:flutter/material.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/res/app_dimensions.dart';

/// Widget, который отображается при переносе карточки
/// для поля feedback виджета LongPressDraggable
class DragItem extends StatelessWidget {
  final SightModel sight;
  final double parentWidth;

  const DragItem({
    Key? key,
    required this.sight,
    required this.parentWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 20,
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimensions.cornerRadius16),
      ),
      color: theme.colorScheme.surface,
      child: SizedBox(
        height: 250,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    AppDimensions.cornerRadius16,
                  ),
                ),
                child: Image.network(
                  sight.url,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.margin16,
                ),
                child: Text(
                  sight.name,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
