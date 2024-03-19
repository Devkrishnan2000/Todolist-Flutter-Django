import 'package:dio/dio.dart' as deo;
import 'package:get/get.dart';
import 'package:todolist/src/task/list/tasklist_controller.dart';
import 'package:todolist/src/task/list/tasklist_model.dart';
import '../../../../api/apis.dart';



class PendingListController extends TaskListController {
  @override
  void onInit() {
    super.onInit();
    loadList();
  }

  Future<void> loadList({
    String? url = '/tasks/list/?completed=False',
  }) async {
    change(taskList, status: RxStatus.loading());
    deo.Response? response = await TaskAPI().listOpenTasks(url!);
    if (response?.statusCode == 200) {
      change(taskList, status: RxStatus.success());
      taskList.value = TaskListModel.fromJSON(response?.data);
    } else {
      change(taskList, status: RxStatus.error("Error Fetching data"));
    }
  }

  // Future<TaskListModel> deleteTask(Task task, previousData) async {
  //   deo.Response? response = await TaskAPI().deleteTask(
  //       task.taskId); // performs api call to delete task from server
  //   if (response?.statusCode == 200) {
  //     // if successful delete that task from list
  //     TaskListModel data = await previousData;
  //     List<dynamic> prevResults = data.results;
  //     prevResults.remove(task);
  //   } else {
  //     throw Exception("Error deleting data");
  //   }
  //   return previousData;
  // }
  //
  // Future<TaskListModel> completeTask(Task task, previousData) async {
  //   deo.Response? response = await TaskAPI().completeTask(
  //       task.taskId); // performs api call to delete task from server
  //   if (response?.statusCode == 200) {
  //     // if successful delete that task from list
  //     TaskListModel data = await previousData;
  //     List<dynamic> prevResults = data.results;
  //     prevResults.remove(task);
  //   } else {
  //     throw Exception("Error changing complete status");
  //   }
  //   return previousData;
  // }
}
