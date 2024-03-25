class User {
  late String name;
  late String password;
  late String email;

  User(this.name, this.email);
  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> usernameToJson() {
    return {"name": name};
  }

  Map<String, dynamic> userToJson() {
    return {"name": name, "email": email};
  }
}
