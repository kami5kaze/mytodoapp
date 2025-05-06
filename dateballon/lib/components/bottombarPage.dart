import 'package:auto_route/auto_route.dart';
import 'package:dateballon/calender.dart';
import 'package:dateballon/home.dart';
import "package:flutter/material.dart";
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

@RoutePage()
class BottombarPage extends HookWidget {
  const BottombarPage({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller =
        PersistentTabController(initialIndex: 1);

    final List<Widget> pages = [
      CalenderPage(),
      Homepage(),
    ];

    return PersistentTabView(
      context,
      controller: controller,
      screens: pages,
      items: _bottombaritems(),
      navBarStyle: NavBarStyle.simple,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _bottombaritems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.calendar_month_outlined),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
