import "package:flutter/material.dart";

class AppbarFunc extends StatelessWidget implements PreferredSizeWidget {
  const AppbarFunc({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Date Balloon"),
      // centerTitle: false,
      backgroundColor: Colors.white.withOpacity(0.3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
