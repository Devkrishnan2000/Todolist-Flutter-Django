import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController {
  Widget floatingButton(int index) {
    if (index == 0) {
      return FloatingActionButton(
        onPressed: () {
          Get.toNamed("/create_task");
          // testNotify();
        },
        child: const Icon(Icons.add),
      );
    } else {
      return Container();
    }
  }
}
