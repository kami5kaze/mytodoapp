import 'package:dateballon/route/auto_route.dart';
import 'package:flutter/material.dart';

final _appRouter = AppRouter();

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Date Ballon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
