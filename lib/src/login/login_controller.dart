import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todolist/src/login/login_model.dart';

import '../../api/apis.dart';
import '../../utils/alert.dart';
import '../task/tasklist_view.dart';

class LoginController {
  void login(BuildContext context, email, password) async {
    LoginModel data = LoginModel(email, password);
    Response? response = await UserAPI().login(data.toJson());
    if (context.mounted) {
      if (response?.statusCode == 200) {
        const storage = FlutterSecureStorage();
        await storage.write(key: "access", value: response?.data?["access"]);
        await storage.write(key: "refresh", value: response?.data?["refresh"]);
        if (context.mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const TaskList()));
        }
      } else if (response?.data["error_code"] == "D1005") {
        Alert()
            .show(context, "Login Failed !", "Please use correct credentials");
      } else if (response?.data["error_code"] == "D1004") {
        Alert().show(context, "Login Failed !", "User doesn't exist");
      } else {
        Alert().show(context, "Login Failed !",
            "Unknown Error has occurred please try again");
      }
    }
  }
}
