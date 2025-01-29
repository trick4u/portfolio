

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TiltController extends GetxController {
  var x = 0.0.obs;
  var y = 0.0.obs;

  final double borderValueY = 150.0;
  final double borderValueX = 200.0;

  void updateTilt(Offset position, Size size) {
    double yvalue = (size.width / 2) - position.dx;
    double xvalue = (size.height / 2) - position.dy;

    if (yvalue <= borderValueY && yvalue >= -borderValueY) {
      double oldRange = (borderValueY - (-borderValueY));
      double newRange = (0.35 - (-0.35));
      double newValueY = (((yvalue - (-borderValueY)) * newRange) / oldRange) + (-0.35);
      double newValueX = (((-xvalue - (-borderValueX)) * newRange) / oldRange) + (-0.35);

      y.value = newValueY;
      x.value = newValueX;
    }
  }

  void resetTilt() {
    y.value = 0.0;
    x.value = 0.0;
  }
}