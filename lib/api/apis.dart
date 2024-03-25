import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:todolist/api/api_connector.dart';

class UserAPI {
  // Class which contains all the app's related to user
  late Dio _dioOpen;
  late Future<Dio> _dioClosed;

  UserAPI() {
    _dioOpen = APIConnector().open; // for open api's
    _dioClosed = APIConnector.protected().closed;
  }
  Future<Response?> register(data) async {
    // api call to register user
    Response? response;
    try {
      response = await _dioOpen.post("account/register/", data: data);
    } on DioException catch (e) {
      response = e.response;
      debugPrint(e.message);
    }
    return response;
  }

  Future<Response?> login(data) async {
    // api call for login
    Response? response;
    try {
      response = await _dioOpen.post("account/login/", data: data);
    } on DioException catch (e) {
      response = e.response;
      debugPrint(e.message);
    }
    return response;
  }

  Future<Response?> userDetails() async {
    Response? response;
    Dio closed = await _dioClosed;
    try {
      response = await closed.get("account/detail/");
    } on DioException catch (e) {
      response = e.response;
      debugPrint(e.message);
    }
    return response;
  }
}

class TaskAPI {
  late Future<Dio> _dioClosed;
  TaskAPI() {
    _dioClosed = APIConnector.protected().closed;
  }

  Future<Response?> listOpenTasks(String url) async {
    Response? response;
    Dio closed = await _dioClosed;
    try {
      response = await closed.get(url);
    } on DioException catch (e) {
      response = e.response;
      debugPrint(e.message);
    }
    return response;
  }

  Future<Response?> deleteTask(int taskId) async {
    Response? response;
    Dio closed = await _dioClosed;
    try {
      response = await closed.delete("tasks/delete/$taskId/");
    } on DioException catch (e) {
      response = e.response;
      debugPrint(e.message);
    }
    return response;
  }

  Future<Response?> completeTask(int taskId) async {
    Response? response;
    Dio closed = await _dioClosed;
    try {
      response = await closed.put("tasks/complete/$taskId/");
    } on DioException catch (e) {
      response = e.response;
      debugPrint(e.message);
    }
    return response;
  }

  Future<Response?> createTask(data) async {
    Response? response;
    Dio closed = await _dioClosed;
    try {
      response = await closed.post("tasks/create/", data: data);
    } on DioException catch (e) {
      response = e.response;
      debugPrint(e.toString());
    }
    return response;
  }
}
