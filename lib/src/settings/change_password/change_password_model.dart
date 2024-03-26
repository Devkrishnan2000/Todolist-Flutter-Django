class ChangePassword {
  late String newPassword;
  late String oldPassword;

  ChangePassword(this.newPassword, this.oldPassword);

  Map<String, dynamic> toJson() {
    return {
      "old_password": oldPassword,
      "password": newPassword,
    };
  }
}
