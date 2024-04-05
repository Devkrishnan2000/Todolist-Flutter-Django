import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/apis.dart';

class CustomNotification {
  CustomNotification._();

  static Future<void> initNotification() async {
    await AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'task_channel_group',
              channelKey: 'task_channel',
              channelName: 'Task notifications',
              channelDescription: 'Notification channel for basic tests',
              importance: NotificationImportance.Max,
              defaultColor: const Color(0xFF9D50DD),
              channelShowBadge: true,
              criticalAlerts: true,
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'Task notifications',
              channelGroupName: 'Task time up notification')
        ],
        debug: true);

    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);

    final receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "task_channel");
    receivePort.asBroadcastStream().listen((event) {
      Get.toNamed("/notification-screen", arguments: [
        {"title": event.title, "id": event.id}
      ]);
    });
  }

  static Future<void> setTaskNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime datetime,
      List<NotificationActionButton>? actionsButtons}) async {
    var localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'task_channel',
          title: title,
          body: body,
          category: NotificationCategory.Alarm,
          fullScreenIntent: true,
          duration: const Duration(seconds: 10),
          locked: false,
          displayOnForeground: false,
        ),
        actionButtons: actionsButtons,
        schedule: NotificationCalendar(
          year: datetime.year,
          month: datetime.month,
          day: datetime.day,
          hour: datetime.hour,
          minute: datetime.minute,
          second: 0,
          timeZone: localTimeZone,
        ));
  }
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint(receivedAction.actionType.toString());
    if (receivedAction.actionType == ActionType.SilentAction &&
        receivedAction.id != null) {
      debugPrint("completed task intiated");
      TaskAPI().completeTask(receivedAction.id!);
    } else {
      Get.offNamed('/notification-screen', arguments: [
        {"title": receivedAction.title, "id": receivedAction.id}
      ]);
    }
  }
}
