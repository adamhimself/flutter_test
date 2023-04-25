import 'dart:math';
import 'package:flutter/material.dart';

class SquareWaveAnimation extends StatefulWidget {
  final double amplitude;
  final double frequency;
  final double initialPhase;

  SquareWaveAnimation({
    required this.amplitude,
    required this.frequency,
    required this.initialPhase,
  });

  @override
  _SquareWaveAnimationState createState() => _SquareWaveAnimationState();
}

class _SquareWaveAnimationState extends State<SquareWaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = widget.amplitude * 2;

    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _SquareWavePainter(
          amplitude: widget.amplitude,
          frequency: widget.frequency,
          initialPhase: widget.initialPhase,
          animationValue: _animation.value,
        ),
        child: SizedBox.expand(
          child: Center(
            child: Container(
              width: widget.amplitude / 2,
              height: widget.amplitude / 2,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SquareWavePainter extends CustomPainter {
  final double amplitude;
  final double frequency;
  final double initialPhase;
  final double animationValue;

  _SquareWavePainter({
    required this.amplitude,
    required this.frequency,
    required this.initialPhase,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final path = Path();
    path.moveTo(0, height / 2);

    final numPoints = 1000;
    final xIncrement = width / numPoints;

    double x = 0;
    double y = 0;

    for (int i = 0; i < numPoints; i++) {
      final radians = (i / numPoints) * pi * 2 * frequency + initialPhase;

      if (sin(radians + animationValue) >= 0) {
        y = amplitude;
      } else {
        y = -amplitude;
      }

      x += xIncrement;

      path.lineTo(x, y + height / 2);
    }

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SquareWavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
