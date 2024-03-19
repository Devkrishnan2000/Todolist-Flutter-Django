import 'package:todolist/src/task/task_model.dart';

class TaskListModel {
  late int count;
  late String? next;
  late String? previous;
  late List<Task> results;

  TaskListModel()
  {
    count=0;
    next=null;
    previous=null;
    results=[];
  }
  TaskListModel.fromJSON(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results = (json['results'] as List).map((i) => Task.fromJSON(i)).toList();
  }
}
