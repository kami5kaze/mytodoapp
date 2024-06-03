import "package:flutter/material.dart";

class DateLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var max = size.height;
    var dashWidth = 5.0;
    var dashSpace = 5.0;
    var startY = max / 8;

    void drawDashedLine(Canvas canvas, Offset start, Offset end,
        double dashWidth, double dashSpace) {
      var max = end.dx;
      var dashLength = dashWidth + dashSpace;

      for (var dx = start.dx; dx < max;) {
        var lineEnd = Offset(dx + dashWidth, start.dy);
        canvas.drawLine(start, lineEnd, paint);
        dx += dashLength;
        start = Offset(dx, start.dy);
      }
    }

    while (startY < max) {
      drawDashedLine(canvas, Offset(0, startY), Offset(size.width, startY),
          dashWidth, dashSpace);
      startY += max / 8;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
