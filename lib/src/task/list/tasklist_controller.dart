import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as deo;
import '../../../api/apis.dart';
import 'tasklist_model.dart';

class TaskListController extends GetxController with StateMixin {
  var taskList = TaskListModel().obs;
  Future<void> loadMoreData() async {
    if (taskList.value.next != null) {
      String nextPageUrl = taskList.value.next as String;
      change(taskList, status: RxStatus.loadingMore());
      deo.Response? response = await TaskAPI().listOpenTasks(nextPageUrl);
      if (response?.statusCode == 200) {
        TaskListModel newData = TaskListModel.fromJSON(response?.data);
        taskList.value.results.addAll(newData.results);
        taskList.value.next = newData.next;
        taskList.value.count = newData.count;
        change(taskList, status: RxStatus.success());
      } else {
        change(taskList, status: RxStatus.error("Error Fetching data"));
      }
    }
  }

  void infinityScroll(ScrollController listScrollController) {
    listScrollController.addListener(() async {
      if (listScrollController.position.pixels ==
          listScrollController.position.maxScrollExtent) {
        loadMoreData();
      }
    });
  }
}
