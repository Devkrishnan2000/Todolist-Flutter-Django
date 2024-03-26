import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/src/settings/change_password/change_password_controller.dart';
import 'package:todolist/utils/animation.dart';
import 'package:todolist/utils/appbar.dart';
import 'package:todolist/utils/text_fields.dart';
import 'package:todolist/utils/text_style.dart';
import 'package:todolist/utils/validation.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});
  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.show(heading: "Change Password"),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Obx(() => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFields.passwordTextField(
                        controller: controller.oldPassword,
                        validation: (value) =>
                            Validation.validatePassword(value),
                        label: "Old password",
                        textInputAction: TextInputAction.next,
                        showHidePassword: () => controller
                            .showHidePassword(controller.isPasswordVisible),
                        isPasswowrdVisible: controller.isPasswordVisible.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFields.passwordTextField(
                        controller: controller.newPassword,
                        validation: (value) => Validation.validateOldRePassword(
                          value,
                          controller.oldPassword.text,
                        ),
                        label: "New password",
                        textInputAction: TextInputAction.next,
                        showHidePassword: () => controller
                            .showHidePassword(controller.isNewPasswordVisible),
                        isPasswowrdVisible:
                            controller.isNewPasswordVisible.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextFields.passwordTextField(
                        controller: controller.rePassword,
                        validation: (value) => Validation.validateRePassword(
                          value,
                          controller.newPassword.text,
                        ),
                        label: "Re enter password ",
                        textInputAction: TextInputAction.next,
                        showHidePassword: () => controller
                            .showHidePassword(controller.isRePasswordVisible),
                        isPasswowrdVisible:
                            controller.isRePasswordVisible.value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () async => controller.changePassword(),
                            child: CustomAnimation.showLoadingAnimation(
                              controller.isLoading.value,
                              Text(
                                'Change password',
                                style: CustomTextStyle.mediumText(),
                              ),
                            )),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
