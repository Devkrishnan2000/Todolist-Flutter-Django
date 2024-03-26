import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/api/apis.dart';
import 'package:todolist/src/settings/settings_controller.dart';
import 'package:todolist/src/settings/user_model.dart';
import 'package:todolist/utils/snack_bar.dart';

class ProfileController extends GetxController {
  final settingsController = Get.find<SettingsController>();
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var isLoading = false.obs;
  var isDataSame = true.obs;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }

  @override
  void onInit() {
    nameController.text = settingsController.user.value.name;
    emailController.text = settingsController.user.value.email;
    isValuesSame();
    super.onInit();
  }

  void isValuesSame() {
    if (nameController.text.compareTo(settingsController.user.value.name) ==
            0 &&
        emailController.text.compareTo(settingsController.user.value.email) ==
            0) {
      debugPrint("same");
      isDataSame.value = true;
    } else {
      isDataSame.value = false;
    }
  }

  void updateUserDetails() async {
    if (formKey.currentState!.validate()) {
      var data = {"name": nameController.text, "email": emailController.text};
      isLoading.value = true;
      dio.Response? response = await UserAPI().updateUserDetails(data);
      if (response?.statusCode == 200) {
        settingsController.user.value = User.fromJson(data);
        Get.back();
        CustomSnackBar.showSuccessSnackBar(
            "Update Successful !", "User details updated");
      } else if (response?.data?['error_code'] == "D1002") {
        CustomSnackBar.showErrorSnackBar(
            "Update Failed!", "Account with same email already exist's");
      } else {
        CustomSnackBar.showErrorSnackBar("Update Failed!", "Server Error");
      }
      isLoading.value = false;
    }
  }
}
