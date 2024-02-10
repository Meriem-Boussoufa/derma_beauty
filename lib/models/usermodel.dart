class UserModel {
  final String? nameUser;
  final String? emailUser;
  final String? passwordUser;
  UserModel({this.nameUser, this.emailUser, this.passwordUser});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nameUser: json["nameUser"],
      emailUser: json['emailUser'],
      passwordUser: json['passwordUser'],
    );
  }
}
