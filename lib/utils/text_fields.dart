import 'package:flutter/material.dart';

class CustomTextFields {
  CustomTextFields._();

  static Widget normalTextField({
    required TextEditingController controller,
    required String? Function(String? value) validation,
    required int maxLength,
    required String label,
    required TextInputAction textInputAction,
    bool counterEnable = false,
    void Function(String?)? onChange,
  }) {
    return TextFormField(
      onChanged: onChange,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        counterText: counterEnable ? null : "",
      ),
      validator: (value) => validation(value),
      maxLength: maxLength,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
    );
  }

  static Widget passwordTextField(
          {required TextEditingController controller,
          required String? Function(String? value) validation,
          required String label,
          required TextInputAction textInputAction,
          required void Function() showHidePassword,
          required bool isPasswowrdVisible,
          bool counterEnable = false}) =>
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          errorMaxLines: 2,
          suffixIcon: IconButton(
            onPressed: () {
              showHidePassword();
            },
            icon: Icon(
                isPasswowrdVisible ? Icons.visibility_off : Icons.visibility),
          ),
          counterText: counterEnable ? null : "",
        ),
        obscureText: !isPasswowrdVisible,
        validator: (value) => validation(value),
        maxLength: 20,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: textInputAction,
      );
}
