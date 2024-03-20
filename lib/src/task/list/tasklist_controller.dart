import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as deo;
import 'package:todolist/src/task/list/tasklist_view.dart';
import 'package:todolist/utils/appcolor.dart';
import '../../../api/apis.dart';
import '../task_model.dart';
import 'tasklist_model.dart';

class TaskListController extends GetxController with StateMixin {
  var taskList = TaskListModel().obs;
  var listKey = GlobalKey<AnimatedListState>().obs;
  final confettiController =
      ConfettiController(duration: const Duration(seconds: 3));
  bool confettiPlayed = false;

  Future<void> loadList({
    String? url = '/tasks/list/',
  }) async {
    change(taskList, status: RxStatus.loading());
    deo.Response? response = await TaskAPI().listOpenTasks(url!);
    if (response?.statusCode == 200) {
      taskList.value = TaskListModel.fromJSON(response?.data);
      taskList.value.results.isEmpty
          ? change(taskList, status: RxStatus.empty())
          : change(taskList, status: RxStatus.success());
    } else {
      change(taskList, status: RxStatus.error("Error Fetching data"));
    }
  }

  Future<void> loadMoreData() async {
    if (taskList.value.next != null) {
      String nextPageUrl = taskList.value.next as String;
      change(taskList, status: RxStatus.loadingMore());
      deo.Response? response = await TaskAPI().listOpenTasks(nextPageUrl);
      if (response?.statusCode == 200) {
        TaskListModel newData = TaskListModel.fromJSON(response?.data);
        int oldListLength = taskList.value.results.length;
        taskList.value.results.addAll(newData.results);
        taskList.value.next = newData.next;
        taskList.value.count = newData.count;
        debugPrint("current list length $oldListLength");
        debugPrint("new data length ${newData.results.length}");
        listKey.value.currentState
            ?.insertAllItems(oldListLength, newData.results.length);
        taskList.value.results.isEmpty
            ? change(taskList, status: RxStatus.empty())
            : change(taskList, status: RxStatus.success());
      } else {
        change(taskList, status: RxStatus.error("Error Fetching data"));
      }
    }
  }

  void infinityScroll(ScrollController listScrollController) {
    listScrollController.addListener(() async {
      // debugPrint("Current Position :${listScrollController.position.pixels.toString()}");
      // debugPrint("Max Position :${listScrollController.position.maxScrollExtent.toString()}");
      if (listScrollController.position.pixels ==
          listScrollController.position.maxScrollExtent) {
        loadMoreData();
      }
    });
  }

  Future<void> deleteTask(
    Task task,
    String tag,
  ) async {
    deo.Response? response = await TaskAPI().deleteTask(
        task.taskId); // performs api call to delete task from server
    if (response?.statusCode == 200) {
      // if successful delete that task from list
      removeFromList(task, tag);
    } else {
      change(taskList, status: RxStatus.error("Error Deleting data"));
    }
  }

  Future<void> completeTask(Task task, String tag) async {
    deo.Response? response = await TaskAPI().completeTask(
        task.taskId); // performs api call to delete task from server
    if (response?.statusCode == 200) {
      // if successful delete that task from list
      await removeFromList(task, tag);
    } else {
      change(taskList, status: RxStatus.error("Error Deleting data"));
    }
  }

  Future<void> removeFromList(Task task, String tag) async {
    int index = taskList.value.results.indexOf(task);
    taskList.value.results.remove(task);
    listKey.value.currentState?.removeItem(index, (context, animation) {
      return AnimatedItem(task: task, tag: tag, animation: animation);
    });
    if (taskList.value.results.length <= 6) {
      debugPrint("added more data");
      await loadMoreData();
    }

    taskList.value.results.isEmpty
        ? change(taskList, status: RxStatus.empty())
        : change(taskList, status: RxStatus.success());
  }

  Widget listEmptyMessage(String tag) {
    if (tag == "pending") {
      if (!confettiPlayed) {
        confettiController.play();
        confettiPlayed = true;
      }

      return Stack(alignment: Alignment.topCenter, children: [
        ConfettiWidget(
          confettiController: confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          emissionFrequency: 0.1,
        ),
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🥳',
                style: TextStyle(fontSize: 96),
              ),
              Text(
                "Hooray !",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                "No pending tasks left",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ]);
    } else {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_alt_rounded,
              size: 120,
              color: AppColor.primaryColor,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "No completed tasks left",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
    }
  }
}
