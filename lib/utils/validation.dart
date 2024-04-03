// class to store all the validations

class Validation {
  Validation._();
  static const String emailValidationMsg = "Invalid email";
  static const String requiredValidationMsg = "Required field";
  static const String nameFieldValidationMsg =
      "Should contain only alphabets and space";
  static const String passwordFieldValidationMsg =
      "Should contain atLeast one capital alphabet character,special character,digit and minimum of 8 digits.";
  static const String passwordMatchValidationMsg = "Password doesn't Match";
  static const String passwordOldMatchValidationMsg =
      "New password cannot be same as old ";
  static const String minimum4CharacterValidationMsg =
      "Minimum 4 characters required";

  static bool emailFieldValidation(String value) {
    if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  static bool requiredFieldValidation(String value) {
    if (value.trim().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static bool minFourCharactersValidation(String value) {
    if (value.trim().length < 4) {
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

  static String? validateName(String? value) {
    if (!Validation.requiredFieldValidation(value!)) {
      return Validation.requiredValidationMsg;
    }
    if (!Validation.nameFieldValidation(value)) {
      return Validation.nameFieldValidationMsg;
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    if (!Validation.requiredFieldValidation(value!)) {
      return Validation.requiredValidationMsg;
    }
    if (!Validation.emailFieldValidation(value)) {
      return Validation.emailValidationMsg;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (!Validation.requiredFieldValidation(value!)) {
      return Validation.requiredValidationMsg;
    }
    if (!Validation.passwordFieldValidation(value)) {
      return Validation.passwordFieldValidationMsg;
    } else {
      return null;
    }
  }

  static String? validateRePassword(String? value, password) {
    if (!Validation.requiredFieldValidation(value!)) {
      return Validation.requiredValidationMsg;
    }
    if (!Validation.passwordMatchValidation(value, password)) {
      return Validation.passwordMatchValidationMsg;
    } else {
      return null;
    }
  }

  static String? validateOldRePassword(String? value, oldPassword) {
    if (value!.isNotEmpty && passwordMatchValidation(value, oldPassword)) {
      return Validation.passwordOldMatchValidationMsg;
    } else {
      return validatePassword(value);
    }
  }

  static String? validateLoginPassword(String? value) {
    if (!Validation.requiredFieldValidation(value!)) {
      return Validation.requiredValidationMsg;
    } else {
      return null;
    }
  }
}
