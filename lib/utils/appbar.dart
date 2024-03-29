import 'package:flutter/material.dart';

class CustomAppBar {
  static PreferredSizeWidget show({String heading = "TodoList"}) {
    return AppBar(
      title: Text(heading,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 32)),
      centerTitle: true,
      flexibleSpace: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/splash.png'),
          ),
        ),
      ),
    );
  }

  static PreferredSizeWidget showLogin(
      {String heading = "TodoList", required double height}) {
    return AppBar(
      toolbarHeight: height,
      title: Text(heading,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 64)),
      centerTitle: true,
      flexibleSpace: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/splash.png'),
          ),
        ),
      ),
    );
  }
}
