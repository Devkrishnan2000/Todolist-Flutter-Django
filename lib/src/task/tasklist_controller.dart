import 'package:dio/dio.dart';

import '../../api/apis.dart';

class TaskListController {
  Future<Map<String, dynamic>> loadList({
    String? url = '/tasks/list/',
  }) async {
    Response? response = await TaskAPI().listOpenTasks(url!);
    if (response?.statusCode == 200) {
      return response?.data;
    } else {
      throw Exception("Error Fetching Data");
    }
  }
}
