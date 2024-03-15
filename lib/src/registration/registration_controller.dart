import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:todolist/src/registration/registration_model.dart';

import '../../api/apis.dart';
import '../../utils/alert.dart';

class RegistrationController {
  void registerUser(BuildContext context, name, email, password) async {
    RegistrationModel data =  RegistrationModel(email, password, name);
    Response? response = await UserAPI().register(data.toJson());
    if (context.mounted) {
      if (response?.statusCode == 201) {
        debugPrint("Registered Successful");
        Alert()
            .show(context, "Success", "You have registered successfully")
            .then((value) => Navigator.of(context).pop());
      } else if (response?.data?["error_code"] == "D1002") {
        Alert().show(
            context, "Registration Failed", "User with same email exists");
      } else {
        Alert().show(context, "Registration Failed",
            "Unknown error occurred please try again");
      }
    }
  }
}
