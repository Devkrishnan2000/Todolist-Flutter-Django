import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appcolor.dart';

class CustomSnackBar {
  static void showErrorSnackBar(String title, String description) {
    Get.snackbar(
      title,
      description,
      backgroundColor: AppColor.pendingLateColor,
      colorText: Colors.white,
      icon: const Icon(
        Icons.error,
        color: Colors.white,
        size: 40,
      ),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
      shouldIconPulse: false,
    );
  }

  static void showSuccessSnackBar(String title, String description) {
    Get.snackbar(
      title,
      description,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: const Icon(
        Icons.task_alt_rounded,
        color: Colors.white,
        size: 40,
      ),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
      shouldIconPulse: false,
    );
  }
}
