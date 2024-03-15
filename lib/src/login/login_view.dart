import 'package:flutter/material.dart';
import 'package:todolist/src/login/login_controller.dart';
import 'package:todolist/src/registration/registration_view.dart';
import 'package:todolist/utils/appcolor.dart';
import 'package:todolist/utils/validation.dart';

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
            const LoginForm(),
          ],
        ),
      ),
    ));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (value) {
                      _email = value!;
                    },
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      counterText: "",
                    ),
                    textInputAction: TextInputAction.next,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (value) {
                      _password = value!;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: const OutlineInputBorder(),
                      counterText: "",
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !isPasswordVisible,
                    validator: (value) {
                      if (!Validation.requiredFieldValidation(value!)) {
                        return Validation.requiredValidationMsg;
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        LoginController().login(context, _email, _password);
                      }
                    },
                    maxLength: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Registration()));
                      },
                      child: const Text(
                        "New ? create an account",
                        style: TextStyle(color: AppColor.primaryColor),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          LoginController().login(context, _email, _password);
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: AppColor.primaryColor),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
