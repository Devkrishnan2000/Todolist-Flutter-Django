import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/src/task/task_cards/task_card_view.dart';
import 'package:todolist/src/task/task_model.dart';
import 'package:todolist/utils/alert.dart';

import 'tasklist_controller.dart';

class TaskListView extends StatefulWidget {
  final String listUrl;
  final String tag;
  const TaskListView({super.key, required this.listUrl, required this.tag});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final scrollController = ScrollController();
  late final TaskListController taskController;
  @override
  void initState() {
    super.initState();
    taskController = Get.put(TaskListController(), tag: widget.tag);
    taskController.loadList(url: widget.listUrl);
    taskController.infinityScroll(scrollController);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return taskController.obx(
      (state) => RefreshIndicator(
        onRefresh: () async {
          await taskController.loadList(url: widget.listUrl);
        },
        child: AnimatedList(
          key: taskController.listKey.value,
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          initialItemCount: taskController.taskList.value.results.length,
          itemBuilder: (context, index, animation) {
            Task task = taskController.taskList.value.results[index];
            return Column(
              children: [
                AnimatedItem(animation: animation, task: task, tag: widget.tag),
              ],
            );
          },
        ),
      ),
      onLoading: const Center(child: CircularProgressIndicator()),
      onError: (error) => Alert().showConnectionError(
          () => taskController.loadList(url: widget.listUrl)),
      onEmpty: taskController.listEmptyMessage(widget.tag),
    );
  }
}

class AnimatedItem extends StatelessWidget {
  final Animation<double> animation;
  final Task task;
  final String tag;
  const AnimatedItem(
      {super.key,
      required this.animation,
      required this.task,
      required this.tag});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: TaskCardView(
        task: task,
        tag: tag,
      ),
    );
  }
}
