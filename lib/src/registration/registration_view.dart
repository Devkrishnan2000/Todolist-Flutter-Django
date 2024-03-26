import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todolist/src/registration/registration_controller.dart';
import 'package:todolist/utils/animation.dart';
import 'package:todolist/utils/appbar.dart';
import 'package:todolist/utils/text_fields.dart';
import 'package:todolist/utils/validation.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.show(heading: "Registration"),
      body: SingleChildScrollView(
        child: SizedBox(
          child: RegistrationForm(),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatelessWidget {
  RegistrationForm({super.key});
  final registrationController = Get.put(RegistrationController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Form(
        key: registrationController.registrationFormKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomTextFields.normalTextField(
                controller: registrationController.nameController,
                validation: (value) => Validation.validateName(value),
                maxLength: 40,
                label: "Name",
                textInputAction: TextInputAction.next,
                counterEnable: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomTextFields.normalTextField(
                controller: registrationController.emailController,
                validation: (value) => Validation.validateEmail(value),
                maxLength: 100,
                label: "Email",
                textInputAction: TextInputAction.next,
                counterEnable: true,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomTextFields.passwordTextField(
                  controller: registrationController.passwordController,
                  validation: (value) => Validation.validatePassword(value),
                  label: "Password",
                  textInputAction: TextInputAction.next,
                  showHidePassword: () =>
                      registrationController.showHidePassword(),
                  isPasswowrdVisible:
                      registrationController.isPasswordVisible.value,
                  counterEnable: true,
                )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomTextFields.passwordTextField(
                controller: registrationController.rePasswordController,
                validation: (value) => Validation.validateRePassword(
                    value, registrationController.passwordController.text),
                label: "Re enter password",
                textInputAction: TextInputAction.next,
                showHidePassword: () =>
                    registrationController.showHideRePassword(),
                isPasswowrdVisible:
                    registrationController.isRePasswordVisible.value,
                counterEnable: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: FilledButton(
                  onPressed: registrationController.isLoading.value
                      ? null
                      : () async => registrationController.registerUser(),
                  child: CustomAnimation.showLoadingAnimation(
                      registrationController.isLoading.value,
                      const Text("Register", style: TextStyle(fontSize: 20))),
                ),
              ),
            )
          ],
        )));
  }
}
