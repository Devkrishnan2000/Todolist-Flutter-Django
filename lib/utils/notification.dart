import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/main.dart';

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
              channelGroupName: 'Task time up notifcation')
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
  }

  static Future<void> setTaskNotification(
      {required int id,
      required String title,
      required String body,
      required DateTime datetime}) async {
    var localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: 'task_channel',
          title: title,
          body: body,
          category: NotificationCategory.Alarm,
          bigPicture: 'asset://assets/images/splash.png',
          notificationLayout: NotificationLayout.BigPicture,
          fullScreenIntent: true,
          duration: const Duration(seconds: 10),
          locked: false,
        ),
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

  // static Future<void> setTaskNotification(
  //     {required int id,
  //     required String title,
  //     required String body,
  //     required DateTime datetime}) async {
  //   AndroidForegroundService.startAndroidForegroundService(
  //       foregroundStartMode: ForegroundStartMode.stick,
  //       foregroundServiceType: ForegroundServiceType.phoneCall,
  //       content: NotificationContent(
  //           id: id,
  //           body: body,
  //           title: title,
  //           channelKey: 'task_channel',
  //           bigPicture: 'asset://assets/images/splash.jpg',
  //           notificationLayout: NotificationLayout.BigPicture,
  //           category: NotificationCategory.Service,
  //           fullScreenIntent: true,
  //           wakeUpScreen: true),
  //       actionButtons: [
  //         NotificationActionButton(
  //             key: 'SHOW_SERVICE_DETAILS', label: 'Show details')
  //       ]);
  // }
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
    debugPrint("called!!!!!");
    // Your code goes here
    Get.offNamed('/notification-screen', arguments: [
      {"title": receivedAction.title}
    ]);
  }
}
