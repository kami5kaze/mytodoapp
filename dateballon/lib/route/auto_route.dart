import 'package:auto_route/auto_route.dart';
import 'package:dateballon/components/bottombarPage.dart';
import 'package:dateballon/login.dart';

part 'auto_route.gr.dart'; // コード生成ファイル

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: BottombarRoute.page),
      ];
}
