import 'package:dio/dio.dart';
import 'package:todolist/src/task/task_model.dart';

import '../../api/apis.dart';

class TaskListController {
  Future<Map<String, dynamic>> loadList({
    String? url = '/tasks/list/',
  }) async {
    Response? response = await TaskAPI().listOpenTasks(url!);
    if (response?.statusCode == 200) {
      return response?.data;
    } else {
      throw Exception("Error fetching data");
    }
  }

  Future<Map<String, dynamic>> deleteTask(Task task, previousData) async {
    Response? response = await TaskAPI().deleteTask(
        task.taskId); // performs api call to delete task from server
    if (response?.statusCode == 200) {
      // if successful delete that task from list
      Map<String, dynamic>? data = await previousData;
      List<dynamic> prevResults = data?['results'];
      for (int i = 0; i < prevResults.length; ++i) {
        Task deleteTask = Task.fromJSON(prevResults[i]);
        if (deleteTask.taskId == task.taskId) {
          prevResults.removeAt(i);
          break;
        }
      }
    } else {
      throw Exception("Error deleting data");
    }
    return previousData;
  }

  Future<Map<String, dynamic>> completeTask(Task task, previousData) async {
    Response? response = await TaskAPI().completeTask(
        task.taskId); // performs api call to delete task from server
    if (response?.statusCode == 200) {
      // if successful delete that task from list
      Map<String, dynamic>? data = await previousData;
      List<dynamic> prevResults = data?['results'];
      for (int i = 0; i < prevResults.length; ++i) {
        Task deleteTask = Task.fromJSON(prevResults[i]);
        if (deleteTask.taskId == task.taskId) {
          prevResults.removeAt(i);
          break;
        }
      }
    } else {
      throw Exception("Error changing complete status");
    }
    return previousData;
  }

  Future<Map<String, dynamic>> loadMoreData(previousData, nextPageUrl) async {
    Map<String, dynamic>? data = await previousData;
    List<dynamic> prevResults = data?['results'];
    Map<String, dynamic>? newData = await loadList(url: nextPageUrl);
    List<dynamic> newResults = newData['results'];
    prevResults.addAll(newResults);
    newData['results'] = prevResults;
    return newData;
  }
}
