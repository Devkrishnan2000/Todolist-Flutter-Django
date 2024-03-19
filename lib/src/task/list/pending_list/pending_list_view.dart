import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/src/task/task_cards/task_card.dart';
import 'package:todolist/src/task/task_model.dart';
import 'package:todolist/src/task/list/pending_list/pending_list_controller.dart';

class PendingListView extends StatefulWidget {
  const PendingListView({super.key});

  @override
  State<PendingListView> createState() => _PendingListViewState();
}

class _PendingListViewState extends State<PendingListView> {
  final scrollController = ScrollController();
  late final taskController = Get.put(PendingListController());
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
