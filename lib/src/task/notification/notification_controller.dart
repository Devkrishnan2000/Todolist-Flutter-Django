import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:todolist/api/apis.dart';

class TaskNotificationController extends GetxController {
  Future<void> completeTaskViaNotification({required int taskId}) async {
    FlutterRingtonePlayer.stop();
    await TaskAPI().completeTask(taskId);
    SystemNavigator.pop();
  }
}
