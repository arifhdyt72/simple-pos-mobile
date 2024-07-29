class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? username;
  final String? password;
  final int? storeId;
  final String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.password,
    this.storeId,
    this.token,
  });

  factory UserModel.formJson(Map<String, dynamic> json) => UserModel(
        id: json['ID'],
        name: json['name'],
        email: json['email'],
        username: json['username'],
        storeId: json['store_id'],
      );

  UserModel copyWith({
    String? password,
    String? token,
  }) =>
      UserModel(
        id: id,
        username: username,
        name: name,
        email: email,
        storeId: storeId,
        token: token ?? this.token,
        password: password ?? this.password,
      );
}
