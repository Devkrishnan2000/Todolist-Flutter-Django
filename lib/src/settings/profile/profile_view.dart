import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/src/settings/profile/profile_controller.dart';
import 'package:todolist/src/settings/settings_controller.dart';
import 'package:todolist/utils/animation.dart';
import 'package:todolist/utils/appbar.dart';
import 'package:todolist/utils/text_fields.dart';
import 'package:todolist/utils/text_style.dart';
import 'package:todolist/utils/validation.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final settingsController = Get.find<SettingsController>();
  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    settingsController.retryGetUserDetails();
    return Scaffold(
      appBar: CustomAppBar.show(heading: "My Profile"),
      body: SingleChildScrollView(
        child: Form(
          key: profileController.formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFields.normalTextField(
                      onChange: (value) => profileController.isValuesSame(),
                      controller: profileController.nameController,
                      validation: (value) => Validation.validateName(value),
                      maxLength: 40,
                      label: "Name",
                      textInputAction: TextInputAction.done,
                      counterEnable: true,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFields.normalTextField(
                    onChange: (value) => profileController.isValuesSame(),
                    controller: profileController.emailController,
                    validation: (value) => Validation.validateEmail(value),
                    maxLength: 100,
                    label: "Email",
                    textInputAction: TextInputAction.done,
                    counterEnable: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Obx(() => FilledButton(
                        onPressed: profileController.isDataSame.value
                            ? null
                            : profileController.isLoading.value
                                ? null
                                : () async =>
                                    profileController.updateUserDetails(),
                        child: CustomAnimation.showLoadingAnimation(
                          isLoading: profileController.isLoading.value,
                          widget: Text(
                            'Update Details',
                            style: CustomTextStyle.mediumText(),
                          ),
                        ))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
