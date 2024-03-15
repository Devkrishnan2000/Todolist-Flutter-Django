class RegistrationModel {
  late String email;
  late String password;
  late String name;

  RegistrationModel(this.email, this.password, this.name);

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "name": name,
    };
  }
}
