import 'dart:math';

import 'package:flutter/material.dart';

class GreenCircleProgressIndicator extends StatefulWidget {
  final double size;
  final Color secondaryColor;
  final Color primaryColor;
  final int lapDuration;
  final double strokeWidth;

  const GreenCircleProgressIndicator({
    Key? key,
    required this.size,
    this.secondaryColor = Colors.white,
    this.primaryColor = Colors.black,
    this.lapDuration = 1000,
    this.strokeWidth = 5.0,
  }) : super(key: key);

  @override
  State<GreenCircleProgressIndicator> createState() =>
      _GreenCircleProgressIndicatorState();
}

class _GreenCircleProgressIndicatorState
    extends State<GreenCircleProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.lapDuration),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(
        begin: 0.0,
        end: 1.0,
      ).animate(controller),
      child: CustomPaint(
        painter: CirclePaint(
          secondaryColor: widget.secondaryColor,
          primaryColor: widget.primaryColor,
          strokeWidth: widget.strokeWidth,
        ),
        size: Size(widget.size, widget.size),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class CirclePaint extends CustomPainter {
  final Color secondaryColor;
  final Color primaryColor;
  final double strokeWidth;
  CirclePaint({
    this.secondaryColor = Colors.white,
    this.primaryColor = Colors.black,
    this.strokeWidth = 15,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerPoint = size.height / 2;

    final paint = Paint()
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = SweepGradient(
        colors: [secondaryColor, primaryColor],
        tileMode: TileMode.repeated,
        startAngle: _degreeToRad(270),
        endAngle: _degreeToRad(270 + 360.0),
      ).createShader(
        Rect.fromCircle(center: Offset(centerPoint, centerPoint), radius: 0),
      );

    final scapSize = strokeWidth * 0.7;
    final scapToDegree = scapSize / centerPoint;

    final startAngle = _degreeToRad(270) + scapToDegree;
    final sweepAngle = _degreeToRad(300) - (scapToDegree * 2);

    canvas.drawArc(
      Offset.zero & Size(size.width, size.width),
      startAngle,
      sweepAngle,
      false,
      paint..color = primaryColor,
    );
  }

  @override
  bool shouldRepaint(CirclePaint oldDelegate) {
    return true;
  }

  double _degreeToRad(double degree) => degree * pi / 180;
}
