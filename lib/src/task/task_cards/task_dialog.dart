import 'package:flutter/material.dart';
import 'package:todolist/src/task/task_model.dart';
import 'package:todolist/utils/appcolor.dart';

class TaskDialog {
  Future show(BuildContext context, Task task,
      Future<dynamic> Function(Task task, BuildContext context) deleteTaskFn) {
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
                              deleteTaskFn(task, context);
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
