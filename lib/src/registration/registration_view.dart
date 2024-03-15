import 'package:flutter/material.dart';

import 'package:todolist/src/registration/registration_controller.dart';

import 'package:todolist/utils/appcolor.dart';
import 'package:todolist/utils/validation.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/splash.png"),
                        fit: BoxFit.fill)),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text(
                      "Registration",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const RegistrationForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();
  final _passwordC = TextEditingController();
  final _rePassword = TextEditingController();
  bool isPasswordVisible = false;
  bool isRePasswordVisible = false;
  String _name = "";
  String _email = "";
  String _password = "";
  RegistrationController controller = RegistrationController();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                onSaved: (value) {
                  _name = value!;
                },
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (!Validation.requiredFieldValidation(value!)) {
                    return Validation.requiredValidationMsg;
                  }
                  if (!Validation.nameFieldValidation(value)) {
                    return Validation.nameFieldValidationMsg;
                  } else {
                    return null;
                  }
                },
                maxLength: 40,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                onSaved: (value) {
                  _email = value!;
                },
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (!Validation.requiredFieldValidation(value!)) {
                    return Validation.requiredValidationMsg;
                  }
                  if (!Validation.emailValidation(value)) {
                    return Validation.emailValidationMsg;
                  } else {
                    return null;
                  }
                },
                maxLength: 100,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                onSaved: (value) {
                  _password = value!;
                },
                controller: _passwordC,
                decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: Icon(isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility))),
                obscureText: !isPasswordVisible,
                validator: (value) {
                  if (!Validation.requiredFieldValidation(value!)) {
                    return Validation.requiredValidationMsg;
                  }
                  if (!Validation.passwordFieldValidation(value)) {
                    return Validation.passwordFieldValidationMsg;
                  } else {
                    return null;
                  }
                },
                maxLength: 20,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _rePassword,
                decoration: InputDecoration(
                    labelText: "Re enter password",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isRePasswordVisible = !isRePasswordVisible;
                          });
                        },
                        icon: Icon(isRePasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility))),
                obscureText: !isRePasswordVisible,
                validator: (value) {
                  if (!Validation.requiredFieldValidation(value!)) {
                    return Validation.requiredValidationMsg;
                  }
                  if (!Validation.passwordMatchValidation(
                      value, _passwordC.text)) {
                    return Validation.passwordMatchValidationMsg;
                  } else {
                    return null;
                  }
                },
                maxLength: 20,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    controller.registerUser(context, _name, _email, _password);
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  controller.registerUser(context, _name, _email, _password);
                }
              },
              child: const Text("Register",
                  style: TextStyle(color: AppColor.primaryColor)),
            )
          ],
        ));
  }
}
