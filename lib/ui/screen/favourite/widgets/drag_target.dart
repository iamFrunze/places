import 'package:flutter/material.dart';
import 'package:places/data/sight_model.dart';

/// Widget для формирования поля child у LongPressDraggable
class DragTargetWidget extends StatelessWidget {
  final DragTargetAccept<SightModel>? onAccept;

  const DragTargetWidget({
    Key? key,
    this.onAccept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<SightModel>(
      builder: (context, accept, reject) {
        return accept.isEmpty ? Container(height: 18) : Container(height: 100);
      },
      onAccept: onAccept,
    );
  }
}
