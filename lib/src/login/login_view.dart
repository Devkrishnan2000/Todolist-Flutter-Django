import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todolist/src/login/login_controller.dart';
import 'package:todolist/utils/appcolor.dart';
import 'package:todolist/utils/animation.dart';
import 'package:todolist/utils/text_fields.dart';
import 'package:todolist/utils/validation.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/splash.png"),
                fit: BoxFit.fill,
              )),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "Todo List",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 64,
                    ),
                  )),
                ],
              ),
            ),
            LoginForm(),
          ],
        ),
      ),
    ));
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Form(
        key: loginController.loginFormKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextFields.normalTextField(
                      controller: loginController.emailController,
                      validation: (value) => Validation.validateEmail(value),
                      maxLength: 100,
                      label: "Email",
                      textInputAction: TextInputAction.next,
                      counterEnable: false,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFields.passwordTextField(
                      controller: loginController.passwordController,
                      validation: (value) => Validation.validatePassword(value),
                      label: "Password",
                      textInputAction: TextInputAction.done,
                      showHidePassword: () =>
                          loginController.showHidePassword(),
                      isPasswowrdVisible:
                          loginController.passwordVisible.value),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        Get.toNamed("/registration");
                      },
                      child: const Text(
                        "New ? create an account",
                        style: TextStyle(color: AppColor.primaryColor),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: FilledButton(
                      onPressed: loginController.isLoading.value
                          ? null
                          : () async => {loginController.login()},
                      child: CustomAnimation.showLoadingAnimation(
                          loginController.isLoading.value,
                          const Text(
                            'Login',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
