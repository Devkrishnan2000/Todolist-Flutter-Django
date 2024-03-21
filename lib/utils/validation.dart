// class to store all the validations

class Validation {
  Validation._();
  static const String emailValidationMsg = "Invalid email";
  static const String requiredValidationMsg = "Required field";
  static const String nameFieldValidationMsg =
      "Should contain only alphabets and space";
  static const String passwordFieldValidationMsg =
      "Should contain atLeast one alphabet character,digit and minimum of 8 digits.";
  static const String passwordMatchValidationMsg = "Password Doesn't Match";
  static bool emailFieldValidation(String value) {
    if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  static bool requiredFieldValidation(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static bool nameFieldValidation(String value) {
    if (RegExp(r'^(?=.*[A-Za-z])[A-Za-z\s]+$').hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  static bool passwordFieldValidation(String value) {
    if (RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+{};:,<.>])[A-Za-z\d!@#\$%^&*()_+]{8,20}$')
        .hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  static bool passwordMatchValidation(String value, String prevValue) {
    if (value == prevValue) {
      return true;
    } else {
      return false;
    }
  }
}
