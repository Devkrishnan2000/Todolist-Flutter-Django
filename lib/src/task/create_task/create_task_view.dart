import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/src/task/create_task/create_task_controller.dart';
import 'package:todolist/utils/animation.dart';
import 'package:todolist/utils/appbar.dart';
import 'package:todolist/utils/text_fields.dart';

class CreateTaskView extends StatelessWidget {
  CreateTaskView({super.key});
  final createTaskController = Get.put(CreateTaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.show(heading: "New Task"),
        body: SingleChildScrollView(
          child: Obx(() => Form(
                key: createTaskController.createTaskFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomTextFields.normalTextField(
                            controller: createTaskController.titleController,
                            validation: (value) =>
                                createTaskController.validateTitle(value),
                            maxLength: 50,
                            label: "Task title",
                            textInputAction: TextInputAction.next,
                            counterEnable: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          controller: createTaskController.descController,
                          decoration: const InputDecoration(
                            labelText: 'Task description',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              createTaskController.validateTitle(value),
                          maxLength: 500,
                          minLines: 10,
                          maxLines: 10,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      OutlinedButton(
                          onPressed: () async {
                            createTaskController.selectDateAndTime(context);
                          },
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.alarm,
                                  ),
                                ),
                                Text(createTaskController
                                    .datetimeButtonLabel.value),
                              ],
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: FilledButton(
                            onPressed: createTaskController.isLoading.value
                                ? null
                                : () async {
                                    createTaskController.createTask();
                                  },
                            child: SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: Center(
                                child: CustomAnimation.showLoadingAnimation(
                                    isLoading:
                                        createTaskController.isLoading.value,
                                    widget: const Text(
                                      'Create Task',
                                      style: TextStyle(fontSize: 24),
                                    )),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              )),
        ));
  }
}
