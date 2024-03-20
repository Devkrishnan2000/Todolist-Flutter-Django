import 'package:flutter/material.dart';

class HomePageController {
  Widget floatingButton(int index) {
    if (index == 0) {
      return FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      );
    } else {
      return Container();
    }
  }
}
