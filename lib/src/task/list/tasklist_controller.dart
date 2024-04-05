import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as deo;
import 'package:todolist/src/task/list/tasklist_view.dart';
import 'package:todolist/utils/appcolor.dart';
import 'package:todolist/utils/snack_bar.dart';
import 'package:todolist/utils/toast.dart';
import '../../../api/apis.dart';
import '../task_model.dart';
import 'tasklist_model.dart';

class TaskListController extends GetxController with StateMixin {
  var taskList = TaskListModel().obs;
  var listKey = GlobalKey<AnimatedListState>().obs;
  var isLoading = false.obs;
  final confettiController =
      ConfettiController(duration: const Duration(seconds: 3));
  bool confettiPlayed = false;

  Future<void> loadList({
    // function to load list for the first time (common for pending and complete list)
    String? url = '/tasks/list/',
  }) async {
    change(taskList, status: RxStatus.loading());
    deo.Response? response = await TaskAPI().listOpenTasks(url!);
    if (response?.statusCode == 200) {
      taskList.value = TaskListModel.fromJSON(response?.data);
      taskList.value.results
              .isEmpty // set's empty status if tasklist is empty after deletion
          ? change(taskList, status: RxStatus.empty())
          : change(taskList, status: RxStatus.success());
    } else {
      change(taskList, status: RxStatus.error("Error Fetching data"));
    }
  }

  Future<void> loadMoreData({bool afterDeletion = false}) async {
    if (taskList.value.next != null && !isLoading.value) {
      // loads next set of data
      late String nextPageUrl;
      if (afterDeletion) {
        debugPrint("inside after deletion");
        Uri initialUri = Uri.parse(taskList.value.next as String);
        Map<String, dynamic> newQueryParameters =
            Map.from(initialUri.queryParameters);
        int oldOffset = int.parse(initialUri.queryParameters['offset']!);
        // after deletion offset need's to be reduced  by number of items that got deleted in this case its 1
        newQueryParameters['offset'] = (oldOffset - 1).toString();
        Uri newUri = initialUri.replace(queryParameters: newQueryParameters);
        nextPageUrl = newUri.toString();
        debugPrint(nextPageUrl);
      } else {
        nextPageUrl = taskList.value.next as String;
      }
      change(taskList, status: RxStatus.loadingMore());
      isLoading.value = true;
      deo.Response? response = await TaskAPI().listOpenTasks(nextPageUrl);
      if (response?.statusCode == 200) {
        TaskListModel newData = TaskListModel.fromJSON(response?.data);
        int oldListLength = taskList.value.results.length;
        taskList.value.results.addAll(newData.results);
        taskList.value.next = newData.next;
        taskList.value.count = newData.count;
        listKey.value.currentState?.insertAllItems(
            oldListLength, newData.results.length,
            duration: const Duration(milliseconds: 500));
        taskList.value.results.isEmpty
            ? change(taskList, status: RxStatus.empty())
            : change(taskList, status: RxStatus.success());
      } else {
        change(taskList, status: RxStatus.error("Error Fetching data"));
      }
      isLoading.value = false;
    }
  }

  void infinityScroll(ScrollController listScrollController) {
    // function which is responsible for infinity scroll
    listScrollController.addListener(() async {
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
      await removeFromList(task, tag);
      CustomToast.show(msg: "Task deleted");
    } else {
      CustomSnackBar.showErrorSnackBar("Operation Failed", "Please Try again");
      change(taskList, status: RxStatus.error("Error Deleting data"));
    }
  }

  Future<void> completeTask(Task task, String tag) async {
    deo.Response? response = await TaskAPI().completeTask(
        task.taskId); // performs api call to completed task from server
    if (response?.statusCode == 200) {
      // if successful delete that task from list
      await removeFromList(task, tag);
      CustomToast.show(msg: "Task completed");
    } else {
      CustomSnackBar.showErrorSnackBar("Operation Failed", "Please Try again");
      change(taskList, status: RxStatus.error("Error Deleting data"));
    }
  }

  Future<void> removeFromList(Task task, String tag) async {
    // function to remove task from the local list after deletion or completion of task is done
    int index = taskList.value.results.indexOf(task);
    taskList.value.results.remove(task); // removes task from list
    // to perform item removal animation
    listKey.value.currentState?.removeItem(index, (context, animation) {
      return AnimatedItem(task: task, tag: tag, animation: animation);
    });
    await loadMoreData(afterDeletion: true);

    taskList.value.results
            .isEmpty // set's empty status if tasklist is empty after deletion
        ? change(taskList, status: RxStatus.empty())
        : change(taskList, status: RxStatus.success());
  }

  Widget listEmptyMessage(String tag) {
    // widget to load when list is empty
    if (tag == "pending") {
      // loads if pending task list empty
      if (!confettiPlayed) {
        confettiController.play(); // play's confetti animation once
        confettiPlayed = true;
      }

      return Stack(alignment: Alignment.topCenter, children: [
        ConfettiWidget(
          confettiController: confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          emissionFrequency: 0.1,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/tasks_completed.png'))),
              ),
              const Text(
                "Hooray !",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                "No pending tasks left",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ]);
    } else {
      return const Center(
        // loads if complete task list empty
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
