import "package:flutter/material.dart";
import 'package:auto_size_text/auto_size_text.dart';

class BalloonCard extends StatelessWidget {
  final String title;
  final String time;
  const BalloonCard({required this.title, required String this.time});

  @override
  Widget build(BuildContext context) {
    List<String> day = time.split(' ');
    return Center(
      child: Container(
        height: 110,
        width: 100,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/balloon.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: AutoSizeText(
                title,
                maxLines: 1,
                maxFontSize: 10.0,
                minFontSize: 9.0,
              ),
            ),
            Text(
              '${day[0]}\n ${day[1]}',
              style: TextStyle(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
