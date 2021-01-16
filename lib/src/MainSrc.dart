
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyColors {

  static const Color primary_background = Color.fromRGBO(16,24,31,1);
  static const Color primary_card = Color.fromRGBO(33,45,59,1);
  static const Color text_gray = Color.fromRGBO(84,104,129,1);
  static const Color text_light = Color.fromRGBO(160,201,253,1);

}


class CircleGraphWidget extends CustomPainter {

  var W,H,color;
  CircleGraphWidget(this.W,this.H,this.color);


  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..lineTo(-W/2, 0)
      ..quadraticBezierTo(W/2, W+W/8 ,W+W/2, 0);
    final path2 = Path()
      ..lineTo((-W/2)-20, 0)
      ..quadraticBezierTo(W/2, (W+W/8)+20 ,(W+W/2)+20, 0);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;
    canvas.drawPath(path, paint);
    final paint2 = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}