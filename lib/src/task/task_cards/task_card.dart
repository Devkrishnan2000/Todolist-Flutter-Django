import 'package:flutter/material.dart';
import 'package:todolist/src/task/task_cards/task_card_controller.dart';
import 'package:todolist/src/task/task_cards/task_dialog.dart';
import 'package:todolist/utils/appcolor.dart';

import '../../../utils/format.dart';
import '../task_model.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final Future<dynamic> Function(Task task, BuildContext context) deleteTaskFn;
  final Future<dynamic> Function(Task task, BuildContext context)
      completeTaskFn;
  const TaskCard(
      {super.key,
      required this.task,
      required this.deleteTaskFn,
      required this.completeTaskFn});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final format = Format();
  bool startAnimation = false;

  @override
  Widget build(BuildContext context) {
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
              children: [
                Flexible(
                  child: Text(
                    widget.task.title,
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
                          TaskDialog()
                              .show(context, widget.task, widget.deleteTaskFn);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: AppColor.pendingLateColor,
                        )),
                    if (!widget.task.completed)
                      IconButton(
                          onPressed: () {
                            widget.completeTaskFn(widget.task, context);
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
                widget.task.description,
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
                          widget.task.date, widget.task.completed)),
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
                              format.formatDate(widget.task.date),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
