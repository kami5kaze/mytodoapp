import 'package:dateballon/dev/dev.dart';
import 'package:dateballon/home.dart';
import "package:flutter/material.dart";
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

var _pages = <Widget>[
  Dev(),
  Homepage(),
  Container(
    child: Text("3"),
  ),
];

class BottombarFunc extends StatelessWidget {
  BottombarFunc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller =
        PersistentTabController(initialIndex: 1);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _pages,
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
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.account_circle),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }
}
