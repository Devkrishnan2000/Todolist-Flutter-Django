import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todolist/src/task/task_model.dart';
import 'package:todolist/utils/appcolor.dart';

import '../list/tasklist_controller.dart';

class DeleteTaskDialog {
  Future show(BuildContext context, Task task, String tag) {
    final taskController = Get.find<TaskListController>(tag: tag);
    return showDialog(
        context: context,
        builder: (context) => SizedBox(
              width: double.infinity,
              child: SimpleDialog(
                elevation: 0,
                backgroundColor: Colors.white,
                title: const Center(
                    child: Text(
                  "Delete task",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                contentPadding: const EdgeInsets.all(15),
                children: [
                  const Center(child: Text('Do you want to delete this task')),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FilledButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Close")),
                        FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: AppColor.pendingLateColor),
                            onPressed: () {
                              taskController.deleteTask(task,tag);
                              Navigator.of(context).pop();
                            },
                            child: const Text("Delete task")),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
