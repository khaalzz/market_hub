import 'package:flutter/material.dart';

class SimpleLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xffe5e7eb)
      ..strokeWidth = 1;

    for (var i = 1; i <= 3; i++) {
      final dy = size.height * i / 4;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), gridPaint);
    }

    final linePaint = Paint()
      ..color = const Color(0xff1d4ed8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x331d4ed8),
          Color(0x00ffffff),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final points = [
      Offset(size.width * 0.0, size.height * 0.65),
      Offset(size.width * 0.18, size.height * 0.68),
      Offset(size.width * 0.36, size.height * 0.55),
      Offset(size.width * 0.54, size.height * 0.50),
      Offset(size.width * 0.72, size.height * 0.35),
      Offset(size.width * 0.9, size.height * 0.40),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (var p in points.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(path, linePaint);

    final fillPath = Path.from(path)
      ..lineTo(points.last.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
