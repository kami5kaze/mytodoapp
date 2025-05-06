import "dart:async";
import "dart:math";

import "package:dateballon/components/appbarFunc.dart";
import "package:dateballon/components/balloon_card.dart";
import "package:dateballon/components/balloon_position.dart";
import "package:dateballon/components/fetchKadai.dart";
import "package:dateballon/paint/dateline.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

class Homepage extends HookWidget {
  final kadaiList = useState(List<Kadai>.empty());
  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final random = Random();
    final existingLeftOffsets = <double>[];

    useEffect(() {
      loadKadai();
      final timer = Timer.periodic(const Duration(hours: 1), (_) {
        loadKadai();
      });
      return timer.cancel;
    }, []);

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
            Stack(fit: StackFit.expand, children: [
              ...kadaiList.value.map((kadai) {
                final deadline = parseDeadline(kadai.dateLine);
                final top = calculateTopOffset(
                    deadline: deadline, screenSize: screenSize);
                final left = generateRandomLeftOffset(
                    existingLeftOffsets, screenSize.width, random);

                existingLeftOffsets.add(left);

                return Positioned(
                  top: top,
                  left: left,
                  child: BalloonCard(
                    title: kadai.title,
                    time: kadai.dateLine,
                  ),
                );
              }),
              Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                  iconSize: 50,
                  icon: const Icon(Icons.restart_alt_outlined),
                  onPressed: () {
                    loadKadai();
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Future<void> loadKadai() async {
    final kadai = await fetchKadaiFromSupabase();
    kadaiList.value = kadai;
  }
}
