


import 'package:flutter/material.dart';

class TiltCard extends StatefulWidget {
  final Widget child;

  const TiltCard({Key? key, required this.child}) : super(key: key);

  @override
  TiltCardState createState() => TiltCardState();
}

class TiltCardState extends State<TiltCard> {
  double x = 0.0;
  double y = 0.0;
  double borderValueY = 150.0;
  double borderValueX = 200.0;
  double beginY = 0.0;
  double endY = 0.0;
  double beginX = 0.0;
  double endX = 0.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder(
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
        tween: Tween(begin: beginX, end: endX),
        builder: (context, valueX, child) => TweenAnimationBuilder(
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: beginY, end: endY),
          builder: (context, valueY, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(valueX as double)
                ..rotateY(valueY as double),
              alignment: FractionalOffset.center,
              child: MouseRegion(
                onHover: (details) {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  final position = box.globalToLocal(details.position);
                  double yvalue = (box.size.width / 2) - position.dx;
                  double xvalue = (box.size.height / 2) - position.dy;

                  if (yvalue <= borderValueY && yvalue >= -borderValueY) {
                    setState(() {
                      double oldRange = (borderValueY - (-borderValueY));
                      double newRange = (0.35 - (-0.35));
                      double newValue =
                          (((yvalue - (-borderValueY)) * newRange) / oldRange) +
                              (-0.35);
                      beginY = y;
                      y = newValue;
                      endY = y;

                      oldRange = (borderValueX - (-borderValueX));
                      newRange = (0.35 - (-0.35));
                      newValue = (((-xvalue - (-borderValueX)) * newRange) /
                              oldRange) +
                          (-0.35);
                      beginX = x;
                      x = newValue;
                      endX = x;
                    });
                  }
                },
                onExit: (event) {
                  setState(() {
                    y = 0.0;
                    x = 0.0;
                    beginY = 0.0;
                    endY = 0.0;
                    beginX = 0.0;
                    endX = 0.0;
                  });
                },
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}