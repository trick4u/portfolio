


import 'package:flutter/material.dart';

class CircularBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Left semicircle with concentric lines
        Positioned(
          left: -150,
          top: MediaQuery.of(context).size.height / 4,
          child: CustomPaint(
            size: Size(300, 300),
            painter: ConcentricCirclesPainter(
              numberOfCircles: 10,
              spacing: 10,
              color: Colors.red.withOpacity(0.1),
            ),
          ),
        ),
        // Bottom right concentric circles
        Positioned(
          right: -100,
          bottom: -100,
          child: CustomPaint(
            size: Size(300, 300),
            painter: ConcentricCirclesPainter(
              numberOfCircles: 10,
              spacing: 10,
              color: Colors.red.withOpacity(0.1),
            ),
          ),
        ),
      ],
    );
  }
}

class ConcentricCirclesPainter extends CustomPainter {
  final int numberOfCircles;
  final double spacing;
  final Color color;

  ConcentricCirclesPainter({
    required this.numberOfCircles,
    required this.spacing,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final double maxRadius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < numberOfCircles; i++) {
      final double radius = maxRadius - (i * spacing);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        0,
        3.14, // Half circle (in radians)
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ConcentricCirclesPainter oldDelegate) => false;
}