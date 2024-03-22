import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todolist/src/registration/registration_controller.dart';
import 'package:todolist/utils/animation.dart';
import 'package:todolist/utils/appbar.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
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
              child: TextFormField(
                controller: registrationController.nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    registrationController.validateName(value),
                maxLength: 40,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: registrationController.emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    registrationController.validateEmail(value),
                maxLength: 100,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: registrationController.passwordController,
                decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          registrationController.showHidePassword();
                        },
                        icon: Icon(
                            registrationController.isPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility))),
                obscureText: !registrationController.isPasswordVisible.value,
                validator: (value) =>
                    registrationController.validatePassword(value),
                maxLength: 20,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: registrationController.rePasswordController,
                decoration: InputDecoration(
                    labelText: "Re enter password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          registrationController.showHideRePassword();
                        },
                        icon: Icon(
                            registrationController.isRePasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility))),
                obscureText: !registrationController.isRePasswordVisible.value,
                validator: (value) =>
                    registrationController.validateRePassword(value),
                maxLength: 20,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  registrationController.registerUser();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: FilledButton(
                  onPressed: () {
                    registrationController.registerUser();
                  },
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
