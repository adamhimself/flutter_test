import 'dart:math';
import 'package:flutter/material.dart';

class SineWaveBackground extends StatefulWidget {
  const SineWaveBackground({Key? key}) : super(key: key);

  @override
  _SineWaveBackgroundState createState() => _SineWaveBackgroundState();
}

class _SineWaveBackgroundState extends State<SineWaveBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 15),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            Container(
              height: screenHeight,
              width: screenWidth,
              color: Colors.white,
            ),
            Positioned(
              bottom: 0.0,
              child: AnimatedContainer(
                duration: const Duration(seconds: 10),
                height: (_controller.value * screenHeight * 0.75),
                width: screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.withOpacity(0.0),
                      Colors.blue.shade900.withOpacity(0.5),
                      Colors.white.withOpacity(1.0),
                    ],
                    stops: [
                      0.0,
                      0.5,
                      1.0,
                    ],
                  ),
                ),
              ),
            ),
            CustomPaint(
              painter: SineWavePainter(
                amplitude: screenHeight * 0.05,
                wavelength: screenWidth * 0.8,
                phase: _controller.value * 0.2 * pi,
              ),
              size: Size(screenWidth, screenHeight),
            ),
          ],
        );
      },
    );
  }
}

class SineWavePainter extends CustomPainter {
  SineWavePainter({
    required this.amplitude,
    required this.wavelength,
    required this.phase,
  });

  final double amplitude;
  final double wavelength;
  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final double halfHeight = size.height / 2;
    final double pointsPerWidth = 100;

    final Path path = Path();
    path.moveTo(0, halfHeight);

    for (double x = 0; x <= size.width; x += size.width / pointsPerWidth) {
      final double y =
          halfHeight + amplitude * sin((x / wavelength) * 2 * pi + phase);
      path.lineTo(x, y);
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(SineWavePainter oldDelegate) =>
      amplitude != oldDelegate.amplitude ||
      wavelength != oldDelegate.wavelength ||
      phase != oldDelegate.phase;
}
