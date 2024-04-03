import 'package:flutter/material.dart';

class CustomAnimation {
  static Widget showLoadingAnimation(
      {required bool isLoading,
      required Widget widget,
      Color spinnerColor = Colors.white}) {
    if (isLoading) {
      return Center(
          child: CircularProgressIndicator(
        color: spinnerColor,
      ));
    } else {
      return widget;
    }
  }
}
