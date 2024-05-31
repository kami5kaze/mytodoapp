import "package:flutter/material.dart";

class BalloonCard extends StatelessWidget {
  final String title;
  final String time;
  const BalloonCard({required this.title, required String this.time});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
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
              child: Text(title),
            ),
            Text(time),
          ],
        ),
      ),
    );
  }
}
