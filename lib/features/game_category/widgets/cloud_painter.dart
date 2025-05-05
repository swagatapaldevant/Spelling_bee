import 'package:flutter/material.dart';

class FullScreenCloudPainter extends CustomPainter {
  final double animationValue;

  FullScreenCloudPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.2);

    // Draw multiple clouds moving across the entire screen
    for (int i = 0; i < 8; i++) {
      // Calculate positions based on animation value
      final xPos = (size.width * (i / 10) + (animationValue * size.width)) %
          (size.width * 1.5);
      final yPos = size.height * 0.1 * (i % 7 + 1);
      final cloudSize = 40.0 + (i % 5) * 20.0;

      _drawCloud(
        canvas,
        paint,
        Offset(xPos, yPos),
        cloudSize,
      );

      // Add some clouds moving in opposite direction
      if (i % 3 == 0) {
        final reverseX =
            (size.width - (animationValue * size.width * 0.7) + (i * 100)) %
                (size.width * 1.5);
        _drawCloud(
          canvas,
          paint,
          Offset(reverseX, yPos + 100),
          cloudSize * 0.8,
        );
      }
    }
  }

  void _drawCloud(Canvas canvas, Paint paint, Offset center, double size) {
    canvas.drawCircle(center.translate(-size * 0.4, 0), size * 0.3, paint);
    canvas.drawCircle(center.translate(size * 0.4, 0), size * 0.3, paint);
    canvas.drawCircle(center.translate(0, -size * 0.2), size * 0.4, paint);
    canvas.drawCircle(
        center.translate(size * 0.1, size * 0.2), size * 0.3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
