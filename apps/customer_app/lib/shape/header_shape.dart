import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(520, 0);
    path_0.lineTo(520, 0);
    path_0.cubicTo(520, 75.1107, 459.111, 136, 384, 136);
    path_0.lineTo(136, 136);
    path_0.cubicTo(60.8893, 136, 0, 75.1107, 0, 0);
    path_0.lineTo(0, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff6FBAE5).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
