import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/src/task/list/tasklist_controller.dart';
import 'package:todolist/src/task/task_cards/delete_task_dialog.dart';
import 'package:todolist/src/task/task_cards/task_card_controller.dart';
import 'package:todolist/utils/appcolor.dart';

import '../../../utils/format.dart';
import '../task_model.dart';

class TaskCardView extends StatelessWidget {
  final String tag;
  final Task task;
  TaskCardView({
    super.key,
    required this.task,
    required this.tag,
  });

  final format = Format();

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskListController>(tag: tag);
    final taskCardController = TaskCardController();
    return Card.outlined(
      color: AppColor.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          DeleteTaskDialog().show(context, task, tag);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: AppColor.pendingLateColor,
                        )),
                    if (!task.completed)
                      IconButton(
                          onPressed: () {
                            taskController.completeTask(task, tag);
                          },
                          icon: const Icon(
                            Icons.task_alt_rounded,
                            color: AppColor.primaryColor,
                          ))
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                task.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: taskCardController.taskChipColor(
                          task.date, task.completed)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(
                            child: Icon(
                          Icons.alarm,
                          color: Colors.white,
                        )),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              format.formatDate(task.date),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
