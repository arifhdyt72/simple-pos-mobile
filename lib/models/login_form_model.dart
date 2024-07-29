class LoginFormModel {
  final String? username;
  final String? password;

  LoginFormModel({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
