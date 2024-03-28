import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class GetPermission {
  GetPermission._();
  static Future<void> getNotificationPermission() async {
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
            permissionInfo:
                "Todolist requires notification permission to send notifcation about their tasks",
            onConfirm: () async => await AwesomeNotifications()
                .requestPermissionToSendNotifications());
      }
    });
    var alarmPermission = await Permission.scheduleExactAlarm.status;
    if (alarmPermission.isDenied) {
      showDialog(
          permissionInfo:
              "Todolist requires exact alarm permssion to set reminders",
          onConfirm: () async => await Permission.scheduleExactAlarm.request());
    }
  }

  static void showDialog(
      // function to show permission dialog
      {required permissionInfo,
      required Future<void> Function() onConfirm}) {
    Get.defaultDialog(
      title: "Permission Access",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold),
      backgroundColor: Colors.white,
      middleText: permissionInfo,
      confirm: FilledButton(
          onPressed: () async {
            await onConfirm();
            Get.back();
          },
          child: const Text("Grant access")),
      cancel: OutlinedButton(
          onPressed: () => Get.back(), child: const Text("Cancel")),
    );
  }
}
