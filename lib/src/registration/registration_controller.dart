import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todolist/src/registration/registration_model.dart';
import 'package:todolist/utils/snack_bar.dart';

import '../../api/apis.dart';
import '../../utils/validation.dart';

class RegistrationController extends GetxController {
  var registrationFormKey = GlobalKey<FormState>(debugLabel: 'registrationKey');
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isRePasswordVisible = false.obs;
  var isLoading = false.obs;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  void showHidePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void showHideRePassword() {
    isRePasswordVisible.value = !isRePasswordVisible.value;
  }

  String? validateName(String? value) {
    if (!Validation.requiredFieldValidation(value!)) {
      return Validation.requiredValidationMsg;
    }
    if (!Validation.nameFieldValidation(value)) {
      return Validation.nameFieldValidationMsg;
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    if (!Validation.requiredFieldValidation(value!)) {
      return Validation.requiredValidationMsg;
    }
    if (!Validation.emailFieldValidation(value)) {
      return Validation.emailValidationMsg;
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    if (!Validation.requiredFieldValidation(value!)) {
      return Validation.requiredValidationMsg;
    }
    if (!Validation.passwordFieldValidation(value)) {
      return Validation.passwordFieldValidationMsg;
    } else {
      return null;
    }
  }

  String? validateRePassword(String? value) {
    if (!Validation.requiredFieldValidation(value!)) {
      return Validation.requiredValidationMsg;
    }
    if (!Validation.passwordMatchValidation(value, passwordController.text)) {
      return Validation.passwordMatchValidationMsg;
    } else {
      return null;
    }
  }

  void registerUser() async {
    if (registrationFormKey.currentState!.validate()) {
      RegistrationModel data = RegistrationModel(
          emailController.text, passwordController.text, nameController.text);
      isLoading.value = true;
      dio.Response? response = await UserAPI().register(data.toJson());
      isLoading.value = false;
      if (response?.statusCode == 201) {
        debugPrint("Registered Successful");
        Get.back();
        CustomSnackBar.showSuccessSnackBar(
            "Registered Successfully", "You may now login");
      } else if (response?.data?["error_code"] == "D1002") {
        CustomSnackBar.showErrorSnackBar(
          "Registration Failed",
          "User with same email exists",
        );
      } else {
        CustomSnackBar.showErrorSnackBar(
          "Registration Failed",
          "Unknown error occurred please try again",
        );
      }
    }
  }
}
