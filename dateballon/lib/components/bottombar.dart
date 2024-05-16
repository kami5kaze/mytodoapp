import "package:flutter/material.dart";

var _pages = <Widget>[];

class Bottombar extends StatelessWidget {
  Bottombar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        screens: _pages,
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            activeColorPrimary: Colors.black,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.comment),
            activeColorPrimary: Colors.black,
            inactiveColorPrimary: Colors.grey,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.account_circle),
            activeColorPrimary: Colors.black,
            inactiveColorPrimary: Colors.grey,
          ),
        ],
        navBarStyle: NavBarStyle.simple,
        backgroundColor: Colors.white,
        decoration: NavBarDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
