import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BalloonCard extends HookWidget {
  final String title;
  final String time;
  const BalloonCard({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    final isVisible = useState(true);

    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;

    final now = DateTime.now();
    final parts = time.split(' ');
    final date = parts[0].split('/');
    final timeParts = parts[1].split(':');

    final deadline = DateTime(
      now.year,
      int.parse(date[0]), // 月
      int.parse(date[1]), // 日
      int.parse(timeParts[0]), // 時
      int.parse(timeParts[1]), // 分
      0, // 秒（常に0秒）
    );

    useEffect(() {
      void checkDeadline() async {
        if (DateTime.now().isAfter(deadline) && isVisible.value) {
          isVisible.value = false;
          final clenderListId = await supabase
              .from('calenders_lists')
              .select('calenders_list_id')
              .eq('user_id', userId)
              .maybeSingle();

          await supabase
              .from('calenders')
              .update({'study': false})
              .eq(
                'calenders_list_id',
                clenderListId!['calenders_list_id'],
              )
              .eq(
                'schedule',
                title,
              )
              .eq(
                'dateLine',
                DateTime(deadline.year, deadline.month, deadline.day),
              );

          // ✅ フレーム後にダイアログを表示
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('課題完了！'),
                content: Text('「$title」は締め切りを迎えました！'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            );
          });
        }
      }

      final timer = Timer.periodic(const Duration(hours: 1), (_) {
        checkDeadline(); // ← 安全に非同期処理
      });

      checkDeadline();

      return timer.cancel;
    }, []);

    List<String> day = time.split(' ');

    if (!isVisible.value) {
      return const SizedBox.shrink(); // 非表示の場合は空のウィジェットを返す
    }

    return Center(
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(title),
              content: SizedBox(
                height: 100,
                width: 200,
                child: Center(
                  child: Text(
                    '締切: $time',
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
          );
        },
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
      ),
    );
  }
}
