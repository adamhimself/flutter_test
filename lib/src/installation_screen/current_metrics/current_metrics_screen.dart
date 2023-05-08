import 'package:flutter/material.dart';
import 'package:taylor_janus/src/common/stat_card.dart';
import 'dart:math';

import 'package:taylor_janus/src/installation_screen/common/carbondioxide_saved.dart';
import 'package:taylor_janus/resources/app_colors.dart';

import '../common/total_power_generated.dart';

class CurrentMetricsScreen extends StatelessWidget {
  const CurrentMetricsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: AnimatedSemiCircle(
            size: 250,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text('OVERVIEW',
                    style: Theme.of(context).textTheme.headlineSmall),
                TotalPowerGenerated(
                  amountInWh: 152,
                  timePeriod: 'today.',
                ),
                CarbondioxideSaved(timePeriod: "today.", amountInKg: 51),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedSemiCircle extends StatefulWidget {
  final double size;

  AnimatedSemiCircle({required this.size});

  @override
  State<AnimatedSemiCircle> createState() => _AnimatedSemiCircleState();
}

class _AnimatedSemiCircleState extends State<AnimatedSemiCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1), // updated duration
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.size, widget.size),
      painter: _SemiCirclePainter(
        animation: _animation,
        color: TaylorLightColors.taylorPrimaryShadeTwo,
      ),
    );
  }
}

class _SemiCirclePainter extends CustomPainter {
  final double strokeWidth = 2;
  final double boxSize = 8;
  final Paint _paint = Paint();
  final Animation<double> animation;
  final Color color;
  final TextPainter _textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  _SemiCirclePainter({required this.animation, required this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final radius = size.width / 3 - strokeWidth / 2;
    const totalLength = 180;

    // Draw transparent semi-circle
    _paint.color = Colors.transparent;
    _paint.strokeWidth = strokeWidth;
    _paint.style = PaintingStyle.stroke;
    canvas.drawArc(rect, 0, 40, true, _paint);

    // Draw boxes along the circumference of the semi-circle
    _paint.color = color;
    _paint.style = PaintingStyle.fill;
    final currentLength = animation.value * totalLength;
    for (double i = 200; i < currentLength + 400; i += boxSize * 2) {
      final angle = i / radius;
      final dx = cos(angle) * radius + size.width / 2;
      final dy = sin(angle) * radius + size.height / 2;
      final rect =
          Rect.fromLTWH(dx - boxSize / 2, dy - boxSize / 2, boxSize, boxSize);
      canvas.drawRect(rect, _paint);
    }

    // Draw text in the center of the circle
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    const text = "1910 W";
    _textPainter.text = TextSpan(
      text: text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
    _textPainter.layout();
    _textPainter.paint(
      canvas,
      Offset(
        centerX - _textPainter.width / 2,
        centerY - _textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(_SemiCirclePainter oldDelegate) =>
      animation != oldDelegate.animation;
}
