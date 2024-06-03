import "package:dateballon/components/appbarFunc.dart";
import "package:dateballon/paint/dateline.dart";
import "package:flutter/material.dart";

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarFunc(),
      body: Container(
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              child: Image(
                image: AssetImage('lib/images/sky.png'),
                fit: BoxFit.fill,
              ),
              foregroundPainter: DateLinePainter(),
            ),
          ],
        ),
      ),
    );
  }
}
