// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:todolist/utils/appcolor.dart';

class TaskCardController {
  Color taskChipColor(DateTime taskTime, bool completed) {
    DateTime currentTime = DateTime.now();
    if (completed) {
      return AppColor.completedTaskColor;
    } else if (currentTime.compareTo(taskTime) > 0)
      return AppColor.pendingLateColor;
    else
      return AppColor.pendingNonLateColor;
  }
}
