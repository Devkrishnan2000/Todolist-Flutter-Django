import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todolist/api/apis.dart';
import 'package:todolist/src/settings/change_password/change_password_model.dart';
import 'package:todolist/utils/snack_bar.dart';

class ChangePasswordController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();
  var rePassword = TextEditingController();
  var isPasswordVisible = false.obs;
  var isRePasswordVisible = false.obs;
  var isNewPasswordVisible = false.obs;
  var isLoading = false.obs;

  void showHidePassword(isVisible) {
    isVisible.value = !isVisible.value;
  }

  void showHideRePassword() {
    isRePasswordVisible.value = !isRePasswordVisible.value;
  }

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    rePassword.dispose();
    super.dispose();
  }

  void changePassword() async {
    if (formKey.currentState!.validate()) {
      var data = ChangePassword(newPassword.text, oldPassword.text).toJson();
      isLoading.value = true;
      dio.Response? response = await UserAPI().updatePassword(data);
      if (response?.statusCode == 200) {
        Get.back();
        CustomSnackBar.showSuccessSnackBar(
            "Updated successfully", "Password has been Changed");
      } else if (response?.data['error_code'] == "D1008") {
        CustomSnackBar.showErrorSnackBar(
            "Updation Failed", "Given old password is incorrect");
      } else {
        CustomSnackBar.showErrorSnackBar("Updation failed", "Server error");
      }
      isLoading.value = false;
    }
  }
}
