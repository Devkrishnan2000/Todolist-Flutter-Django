import 'package:flutter/material.dart';

class CustomAnimation {
  static Widget showLoadingAnimation(bool isLoading, Widget widget) {
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      ));
    } else {
      return widget;
    }
  }
}
