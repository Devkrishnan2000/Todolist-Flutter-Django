import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  String formatDate(DateTime date) {
    final formatter = DateFormat(Format.dateTimeFormat);
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    const Center(child: Icon(Icons.alarm)),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(formatDate(widget.task.date)),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
