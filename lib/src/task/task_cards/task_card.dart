import 'package:flutter/material.dart';
import 'package:todolist/src/task/task_cards/task_card_controller.dart';
import 'package:todolist/src/task/task_cards/task_dialog.dart';
import 'package:todolist/utils/appcolor.dart';

import '../../../utils/format.dart';
import '../task_model.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final format = Format();

  @override
  Widget build(BuildContext context) {
    final taskCardController = TaskCardController();
    return InkWell(
      onLongPress: () {
        TaskDialog().show(context, widget.task);
      },
      child: Card.outlined(
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
                  if (!widget.task.completed)
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.task_alt_rounded,
                          color: AppColor.primaryColor,
                        ))
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
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
      ),
    );
  }
}
