import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:todolist/src/login/login_model.dart';
import 'package:todolist/utils/snack_bar.dart';
import '../../api/apis.dart';

class LoginController extends GetxController {
  var loginFormKey = GlobalKey<FormState>(debugLabel: 'loginKey');
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordVisible = false.obs;
  var isLoading = false.obs;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showHidePassword() {
    passwordVisible.value = !passwordVisible.value;
  }

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      LoginModel data =
          LoginModel(emailController.text, passwordController.text);
      isLoading.value = true;
      dio.Response? response = await UserAPI().login(data.toJson());
      isLoading.value = false;
      if (response?.statusCode == 200) {
        const storage = FlutterSecureStorage();
        await storage.write(key: "access", value: response?.data?["access"]);
        await storage.write(key: "refresh", value: response?.data?["refresh"]);
        Get.offNamed("/");
      } else if (response?.data["error_code"] == "D1005") {
        CustomSnackBar.showErrorSnackBar(
          "Login Failed !",
          "Please use correct credentials",
        );
      } else if (response?.data["error_code"] == "D1004") {
        CustomSnackBar.showErrorSnackBar(
          "Login Failed !",
          "User doesn't exist",
        );
      } else {
        CustomSnackBar.showErrorSnackBar(
          "Login Failed !",
          "Server error",
        );
      }
    }
  }
}
