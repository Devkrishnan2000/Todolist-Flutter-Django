class LoginModel {
  late String email;
  late String password;

  LoginModel(this.email, this.password);

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
