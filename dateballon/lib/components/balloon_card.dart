import "package:flutter/material.dart";

class BalloonCard extends StatelessWidget {
  final String title;
  final String time;
  const BalloonCard({required this.title, required String this.time});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: BallonShapePainter(),
        child: Container(
          width: 200,
          height: 100,
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                child: Text(title),
                padding: EdgeInsetsDirectional.all(5),
              ),
              Text(time),
            ],
          ),
        ),
      ),
    );
  }
}

//風船の描画
class BallonShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white;

    Path path = Path()
      ..moveTo(size.width / 2, size.height) //bottom center
      ..lineTo(size.width / 2 - 10, size.height - 10)
      ..arcToPoint(
        Offset(size.width / 2 + 10, size.height - 10),
        radius: Radius.circular(10),
        clockwise: false,
      )
      ..close();

    canvas.drawPath(path, paint);

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height - 10);
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(20));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
