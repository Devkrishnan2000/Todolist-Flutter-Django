import 'package:dio/dio.dart' as deo;
import 'package:get/get.dart';
import 'package:todolist/src/task/list/tasklist_controller.dart';
import 'package:todolist/src/task/list/tasklist_model.dart';
import '../../../../api/apis.dart';



class CompleteListController extends TaskListController {
  Future<void> loadList({
    String? url = '/tasks/list/?completed=True',
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
}
