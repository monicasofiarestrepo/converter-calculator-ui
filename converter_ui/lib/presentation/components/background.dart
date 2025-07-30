import 'package:flutter/material.dart';
import 'package:converter_ui/core/theme/dorado_colors.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _BackgroundPainter(),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lightBlue = DoradoColors.backgroundBlue;
    final dorado = DoradoColors.backgroundOrange;

    final bgPaint = Paint()..color = lightBlue;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final orangePaint = Paint()..color = dorado;

    final circleCenter = Offset(size.width * 2.1, size.height * 0.37);
    final radius = size.height * 0.73;

    canvas.drawCircle(circleCenter, radius, orangePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
