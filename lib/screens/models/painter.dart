import 'dart:math' as Math;
import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  final int totalTicks;
  final Color color;

  Painter({required this.totalTicks, this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < totalTicks; i++) {
      double angle = (i * (360 / totalTicks)) * (Math.pi / 180);
      double innerRadius = radius - 10; 
      double outerRadius = radius;      

      final p1 = Offset(
        center.dx + innerRadius * Math.cos(angle),
        center.dy + innerRadius * Math.sin(angle),
      );
      final p2 = Offset(
        center.dx + outerRadius * Math.cos(angle),
        center.dy + outerRadius * Math.sin(angle),
      );

      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
