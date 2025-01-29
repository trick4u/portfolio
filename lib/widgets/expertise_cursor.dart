// expertise_cursor.dart
import 'package:flutter/material.dart';

class ExpertiseCursor extends StatefulWidget {
  final Widget child;

  const ExpertiseCursor({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ExpertiseCursor> createState() => _ExpertiseCursorState();
}

class _ExpertiseCursorState extends State<ExpertiseCursor> {
  Offset position = Offset.zero;
  bool isHovered = false;
  final GlobalKey _parentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The main content
        MouseRegion(
          key: _parentKey,
          onHover: (event) {
            setState(() {
              RenderBox getBox = _parentKey.currentContext?.findRenderObject() as RenderBox;
              position = getBox.globalToLocal(event.position);
              isHovered = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHovered = false;
            });
          },
          child: widget.child,
        ),
        // The cursor
        if (isHovered)
          Positioned(
            left: position.dx - 20,
            top: position.dy - 20,
            child: IgnorePointer(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 200),
                builder: (context, value, child) => Transform.scale(
                  scale: value,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.touch_app_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}