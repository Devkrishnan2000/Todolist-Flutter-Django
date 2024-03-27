class Profile {
  late String name;
  late String email;

  Profile(this.name, this.email);

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email};
  }
}
