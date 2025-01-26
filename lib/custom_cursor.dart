import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomCursor extends StatefulWidget {
  final Widget child;
  const CustomCursor({Key? key, required this.child}) : super(key: key);

  @override
  State<CustomCursor> createState() => _CustomCursorState();
}

class _CustomCursorState extends State<CustomCursor> with SingleTickerProviderStateMixin {
  Offset _position = Offset.zero;
  Offset _trailingPosition = Offset.zero;
  late AnimationController _controller;
  final GlobalKey _key = GlobalKey();
  Color _cursorColor = Colors.red;
  
  final Map<String, Color> _sectionColors = {
    'PROFILE': Colors.blue,
    'TECHNICAL EXPERTISE': Colors.green,
    'PROFESSIONAL EXPERIENCE': Colors.purple,
    'EDUCATION': Colors.orange,
    'CERTIFICATES': Colors.teal,
    'PROJECTS': Colors.amber,
    'INTERESTS': Colors.pink,
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(_updateTrailingPosition);
    _controller.repeat();
  }

  void _updateTrailingPosition() {
    setState(() {
      _trailingPosition = Offset(
        _trailingPosition.dx + (_position.dx - _trailingPosition.dx) * 0.1,
        _trailingPosition.dy + (_position.dy - _trailingPosition.dy) * 0.1,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updatePosition(PointerEvent event) {
    RenderBox? box = _key.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      final localPosition = box.globalToLocal(event.position);
      setState(() {
        _position = localPosition;
        _updateCursorColor(event.position);
      });
    }
  }

  void _updateCursorColor(Offset globalPosition) {
    final RenderBox? box = _key.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    // Hit test at the current position
    final result = BoxHitTestResult();
    box.hitTest(result, position: box.globalToLocal(globalPosition));

    // Check hit test results for section headers
    for (final hit in result.path) {
      if (hit.target is RenderParagraph) {
        final text = (hit.target as RenderParagraph).text?.toPlainText() ?? '';
        for (final entry in _sectionColors.entries) {
          if (text.contains(entry.key)) {
            setState(() {
              _cursorColor = entry.value;
            });
            return;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: _updatePosition,
      child: Stack(
        key: _key,
        fit: StackFit.passthrough,
        children: [
          widget.child,
          if (_position != Offset.zero)
            Positioned.fill(
              child: IgnorePointer(
                child: Stack(
                  children: [
                    Positioned(
                      left: _position.dx - 2,
                      top: _position.dy - 2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _cursorColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      left: _trailingPosition.dx - 8,
                      top: _trailingPosition.dy - 8,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(color: _cursorColor, width: 1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}