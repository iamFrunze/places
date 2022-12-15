import 'package:flutter/material.dart';
import 'package:places/res/app_colors.dart';

class AnimatedPositionMarkWidget extends StatefulWidget {
  const AnimatedPositionMarkWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedPositionMarkWidget> createState() =>
      _AnimatedPositionMarkWidgetState();
}

class _AnimatedPositionMarkWidgetState extends State<AnimatedPositionMarkWidget>
    with TickerProviderStateMixin {
  late Animation<double> _innerAnimation;
  late Animation<double> _outAnimation;

  late AnimationController _innerController;
  late AnimationController _outController;

  @override
  void initState() {
    super.initState();
    _innerController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _outController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _innerAnimation = Tween<double>(begin: 0, end: 64).animate(_innerController)
      ..addListener(() => setState(() {}));
    _outAnimation = Tween<double>(begin: 0, end: 104).animate(_outController)
      ..addListener(() => setState(() {}));
    _innerController.repeat(reverse: true);
    _outController.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    _innerController.dispose();
    _outController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: _outAnimation.value,
          height: _outAnimation.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.animatedPosMark.withOpacity(0.12),
          ),
        ),
        Container(
          width: _innerAnimation.value,
          height: _innerAnimation.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.animatedPosMark.withOpacity(0.24),
          ),
        ),
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.8],
              colors: [
                AppColors.endGradientSplashColor,
                AppColors.startGradientSplashColor,
              ],
            ),
            border: Border.all(
              color: Colors.white,
            ),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
