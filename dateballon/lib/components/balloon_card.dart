import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";

class BalloonCard extends StatelessWidget {
  final String title;
  final String time;
  const BalloonCard({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    List<String> day = time.split(' ');
    return Center(
      child: Container(
        height: 110,
        width: 100,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/balloon.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AutoSizeText(
                title,
                maxLines: 1,
                maxFontSize: 10.0,
                minFontSize: 9.0,
              ),
            ),
            Text(
              '${day[0]}\n ${day[1]}',
              style: const TextStyle(
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
