import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/api/apis.dart';
import 'package:todolist/src/settings/settings_controller.dart';
import 'package:todolist/utils/snack_bar.dart';
import 'package:todolist/utils/text_style.dart';

import '../../../utils/validation.dart';

class ProfileController extends GetxController {
  final settingsController = Get.find<SettingsController>();
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController.text = settingsController.user.value.name;
    emailController.text = settingsController.user.value.email;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
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

  void updateUserDetailsDialog() {
    Get.defaultDialog(
      title: 'Update Name',
      titleStyle: CustomTextStyle.subHeading1(),
      content: SizedBox(
        width: Get.width,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Name"),
                  controller: nameController,
                  validator: (value) => validateName(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email"),
                  controller: emailController,
                  validator: (value) => validateEmail(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
            ],
          ),
        ),
      ),
      confirm: FilledButton(
        onPressed: () async => updateUserName(),
        child: Obx(
          () => isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Text('Update'),
        ),
      ),
      cancel: OutlinedButton(
          onPressed: () => Get.back(), child: const Text('Cancel')),
    );
  }

  void updateUserName() async {
    if (formKey.currentState!.validate()) {
      var data = {"name": nameController.text, "email": emailController.text};
      isLoading.value = true;
      dio.Response? response = await UserAPI().updateUserDetails(data);
      if (response?.statusCode == 200) {
        settingsController.user.value.name = nameController.text;
        settingsController.user.value.email = emailController.text;
        Get.back();
        CustomSnackBar.showSuccessSnackBar(
            "Update Successful !", "Name Updated");
      } else {
        CustomSnackBar.showErrorSnackBar("Update Failed!", "Server Error");
      }
      isLoading.value = false;
    }
  }
}
