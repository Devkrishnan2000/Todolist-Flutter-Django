import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todolist/src/login/login_controller.dart';
import 'package:todolist/utils/appcolor.dart';
import 'package:todolist/utils/animation.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                  child: TextFormField(
                    controller: loginController.emailController,
                    validator: (value) => loginController.emailValidator(value),
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      counterText: "",
                    ),
                    textInputAction: TextInputAction.next,
                    maxLength: 100,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: loginController.passwordController,
                    validator: (value) =>
                        loginController.passwordValidator(value),
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: const OutlineInputBorder(),
                      counterText: "",
                      suffixIcon: IconButton(
                        icon: Icon(loginController.passwordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          loginController.showHidePassword();
                        },
                      ),
                    ),
                    obscureText: !loginController.passwordVisible.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      loginController.login();
                    },
                    maxLength: 20,
                  ),
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
                      onPressed: () async {
                        loginController.isLoading.value
                            ? null
                            : loginController.login();
                      },
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
