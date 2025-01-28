import 'package:flutter/material.dart';
import 'dart:math' as math;

// Semi-circle widget
class SemiCircleWidget extends StatelessWidget {
  final double size;
  final Color color;

  const SemiCircleWidget({
    Key? key,
    required this.size,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive size based on layout constraints
        final double responsiveSize = size.clamp(
          0.0,
          math.min(constraints.maxWidth, constraints.maxHeight),
        );

        return Container(
          width: responsiveSize,
          height: responsiveSize,
          child: CustomPaint(
            size: Size(responsiveSize, responsiveSize),
            painter: SemiCirclePainter(
              color: color,
              scaleFactor:
                  responsiveSize / size, // Pass scale factor to painter
            ),
          ),
        );
      },
    );
  }
}

class SemiCirclePainter extends CustomPainter {
  final Color color;
  final double scaleFactor;

  SemiCirclePainter({
    this.color = Colors.black,
    this.scaleFactor = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true; // Smooth edges

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = (size.width / 2) * scaleFactor;

    // Create path for semi-circle
    final Path path = Path();
    path.addArc(
      Rect.fromCircle(
        center: Offset(centerX, centerY),
        radius: radius,
      ),
      math.pi / 2,
      math.pi,
    );

    // Apply scaling transform if needed
    if (scaleFactor != 1.0) {
      final Matrix4 matrix = Matrix4.identity()
        ..scale(scaleFactor, scaleFactor);
      path.transform(matrix.storage);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SemiCirclePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.scaleFactor != scaleFactor;
  }
}

// Curved lines widget
class CurvedLinesWidget extends StatefulWidget {
  final double width;
  final double height;
  final double lineSpacing;

  const CurvedLinesWidget({
    Key? key,
    this.width = 400,
    this.height = 200,
    this.lineSpacing = 8.0,
  }) : super(key: key);

  @override
  _CurvedLinesWidgetState createState() => _CurvedLinesWidgetState();
}

class _CurvedLinesWidgetState extends State<CurvedLinesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _colorAnimation = ColorTween(
      begin: Colors.deepPurpleAccent,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Add status listener to handle animation completion
    _controller.addStatusListener(_handleAnimationStatus);
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
      if (mounted && !_isDisposed) {
        setState(() {
          // Ensure widget is still active
        });
      }
    }
  }

  @override
  void didUpdateWidget(CurvedLinesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reinitialize animations if needed
    if (!_controller.isAnimating && mounted && !_isDisposed) {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.removeStatusListener(_handleAnimationStatus);
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovering) {
    if (!mounted || _isDisposed) return;

    try {
      if (isHovering) {
        if (!_controller.isAnimating) {
          _controller.forward();
        }
      } else {
        if (!_controller.isAnimating) {
          _controller.reverse();
        }
      }
    } catch (e) {
      // If animation controller is in an invalid state, reinitialize
      if (mounted && !_isDisposed) {
        _initializeAnimations();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          // Ensure color animation value is valid
          final Color currentColor = _colorAnimation.value ?? Colors.deepPurpleAccent;
          
          return CustomPaint(
            size: Size(widget.width, widget.height),
            painter: CurvedLinesPainter(
              color: currentColor,
              lineSpacing: widget.lineSpacing,
            ),
          );
        },
      ),
    );
  }
}

class CurvedLinesPainter extends CustomPainter {
  final Color color;
  final double lineSpacing;

  CurvedLinesPainter({
    this.color = Colors.red,
    this.lineSpacing = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final int lineCount = 25;
    final double radius = size.width / 2;

    for (int i = 0; i < lineCount; i++) {
      final Path path = Path();
      final double currentRadius = radius - (i * lineSpacing);

      // Draw half circle path
      path.addArc(
        Rect.fromCircle(
          center: Offset(0, size.height / 2),
          radius: currentRadius,
        ),
        -math.pi / 2,
        math.pi,
      );

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
