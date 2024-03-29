import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:todolist/api/apis.dart';
import 'package:todolist/src/settings/user_model.dart';
import 'package:todolist/utils/appcolor.dart';

class SettingsController extends GetxController {
  var user = User('', '').obs;

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    dio.Response? response = await UserAPI().userDetails();
    if (response?.statusCode == 200) {
      user.value = User.fromJson(response?.data);
    }
  }

  void retryGetUserDetails() {
    if (user.value.email.isEmpty) {
      getUserDetails();
    }
  }

  void logout() async {
    Get.defaultDialog(
      title: 'Confirm action',
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      middleText: 'Are you sure you want logout ?',
      confirm: FilledButton(
        style:
            FilledButton.styleFrom(backgroundColor: AppColor.pendingLateColor),
        onPressed: () async => onlogout(),
        child: const Text('Log out'),
      ),
      cancel: OutlinedButton(
          onPressed: () => Get.back(), child: const Text('Cancel')),
      backgroundColor: AppColor.cardColor,
    );
  }

  void onlogout() async {
    const storage = FlutterSecureStorage();
    await storage.write(key: "access", value: '');
    await storage.write(key: "refresh", value: '');
    await AwesomeNotifications().cancelAll();
    Get.back();
    Get.offNamed("/login");
  }

  String getCurrentUsername() {
    if (user.value.name.isNotEmpty) {
      return 'Logged in as ${user.value.name}';
    } else {
      return "Couldn't get user info";
    }
  }
}
