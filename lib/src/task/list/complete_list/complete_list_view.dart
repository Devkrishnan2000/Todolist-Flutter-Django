import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/src/task/list/complete_list/complete_list_controller.dart';
import 'package:todolist/src/task/task_cards/task_card.dart';
import 'package:todolist/src/task/task_model.dart';

import 'complete_list_controller.dart';

class CompleteListView extends StatefulWidget {
  const CompleteListView({super.key});

  @override
  State<CompleteListView> createState() => _CompleteListViewState();
}

class _CompleteListViewState extends State<CompleteListView> {
  final scrollController = ScrollController();
  late final taskController = Get.put(CompleteListController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskController.infinityScroll(scrollController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return taskController.obx(
        (state) => RefreshIndicator(
              onRefresh: () async {
                await taskController.loadList();
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: taskController.taskList.value.results.length,
                itemBuilder: (context, index) {
                  Task task = taskController.taskList.value.results[index];
                  return TaskCard(task: task);
                },
              ),
            ),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) => Text(error!));
  }
}
