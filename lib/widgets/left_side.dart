import 'package:flutter/material.dart';
import 'circular_background.dart';

class LeftWidget extends StatelessWidget {
  const LeftWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobileLayout = MediaQuery.of(context).size.width < 600;

    if (isMobileLayout) {
      return SizedBox.shrink();
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final double curvedLinesWidth = screenWidth * 0.3;
    final double semiCircleSize = screenWidth * 0.2;
    final double curvedLinesHeight = screenWidth * 0.1;

    return Container(
      width: screenWidth * 0.3,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Top curved lines with semi-circle
          Positioned(
            top: 0,
            left: -curvedLinesWidth * 0.2,
            child: RotatedBox(
              quarterTurns: 1,
              child: CurvedLinesWidget(
                width: curvedLinesWidth,
                height: curvedLinesHeight,
                lineSpacing: 12.0,
              ),
            ),
          ),
          Positioned(
            top: -curvedLinesHeight * 0.9,
            left: curvedLinesWidth * 0.3,
            child: RotatedBox(
              quarterTurns: 3,
              child: SemiCircleWidget(
                size: semiCircleSize,
                color: Colors.black,
              ),
            ),
          ),

          // Concentric circles in the middle
          Positioned(
            top: screenWidth * 0.15,
            left: -curvedLinesWidth * 0.1,
            child: ConcentricCircleWidget(
              size: semiCircleSize * 1,
              colors: [Colors.blue, Colors.green, Colors.yellow],
            ),
          ),

          // Bottom semi-circle with curved lines
          Positioned(
            bottom: screenWidth * 0.1,
            left: 0,
            child: SemiCircleWidget(
              size: semiCircleSize,
              color: Colors.black,
            ),
          ),
          Positioned(
            bottom: screenWidth * 0.1,
            left: semiCircleSize * 0.5,
            child: CurvedLinesWidget(
              width: curvedLinesWidth * 1.5,
              height: curvedLinesHeight * 2,
              lineSpacing: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}

// New ConcentricCircleWidget
class ConcentricCircleWidget extends StatefulWidget {
  final double size;
  final List<Color> colors;

  const ConcentricCircleWidget({
    required this.size,
    required this.colors,
    super.key,
  });

  @override
  State<ConcentricCircleWidget> createState() => _ConcentricCircleWidgetState();
}

class _ConcentricCircleWidgetState extends State<ConcentricCircleWidget>
    with SingleTickerProviderStateMixin {
  int? activeRegion;
  Offset? mousePosition;
  late AnimationController _controller;
  late List<Animation<double>> _fillAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Create animations for each region
    _fillAnimations = List.generate(
      widget.colors.length,
      (i) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            i * (1 / widget.colors.length),
            (i + 1) * (1 / widget.colors.length),
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateHoverRegion(Offset localPosition) {
    final center = Offset(widget.size / 2, widget.size / 2);
    final distance = (localPosition - center).distance;
    final maxRadius = widget.size / 2;

    // Calculate which region the mouse is in
    for (int i = 0; i < widget.colors.length; i++) {
      final outerBound =
          maxRadius * (widget.colors.length - i) / widget.colors.length;
      final innerBound = i > 0
          ? maxRadius * (widget.colors.length - i - 1) / widget.colors.length
          : 0;

      if (distance <= outerBound && distance >= innerBound) {
        if (activeRegion != widget.colors.length - 1 - i) {
          setState(() {
            activeRegion = widget.colors.length - 1 - i;
            _controller.forward(from: 0.0);
          });
        }
        return;
      }
    }

    // Mouse is outside all regions
    if (activeRegion != null) {
      setState(() {
        activeRegion = null;
        _controller.reverse();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => _updateHoverRegion(event.localPosition),
      onExit: (_) => setState(() {
        activeRegion = null;
        _controller.reverse();
      }),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _ConcentricCirclePainter(
              colors: widget.colors,
              activeRegion: activeRegion,
              fillAnimations: _fillAnimations,
            ),
          );
        },
      ),
    );
  }
}

class _ConcentricCirclePainter extends CustomPainter {
  final List<Color> colors;
  final int? activeRegion;
  final List<Animation<double>> fillAnimations;

  _ConcentricCirclePainter({
    required this.colors,
    required this.activeRegion,
    required this.fillAnimations,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double maxRadius = size.width / 2;

    // Draw from outer to inner circles
    for (int i = 0; i < colors.length; i++) {
      final double outerRadius =
          maxRadius * (colors.length - i) / colors.length;
      final double innerRadius = i < colors.length - 1
          ? maxRadius * (colors.length - i - 1) / colors.length
          : 0;

      // Draw outline
      final Paint outlinePaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(Offset(centerX, centerY), outerRadius, outlinePaint);

      // Handle fill based on active region
      if (activeRegion != null) {
        if (i == activeRegion) {
          // Fill the ring between outer and inner radius
          final Path fillPath = Path()
            ..addOval(Rect.fromCircle(
              center: Offset(centerX, centerY),
              radius: outerRadius,
            ))
            ..addOval(Rect.fromCircle(
              center: Offset(centerX, centerY),
              radius: innerRadius,
            ));

          final Paint fillPaint = Paint()
            ..color = colors[i].withOpacity(fillAnimations[i].value)
            ..style = PaintingStyle.fill;

          canvas.drawPath(fillPath, fillPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ConcentricCirclePainter oldDelegate) {
    return oldDelegate.activeRegion != activeRegion ||
        oldDelegate.fillAnimations != fillAnimations ||
        oldDelegate.colors != colors;
  }
}
