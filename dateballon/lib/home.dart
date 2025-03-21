import "package:dateballon/components/appbarFunc.dart";
import "package:dateballon/paint/dateline.dart";
import "package:flutter/material.dart";

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarFunc(),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              foregroundPainter: DateLinePainter(),
              child: const Image(
                image: AssetImage('lib/images/sky.png'),
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
