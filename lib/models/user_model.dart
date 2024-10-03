import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? userName;
  String? userEmail;
  String? createdAt;
  String? userImage;
  String? userId;

  UserModel({
    this.userName,
    this.userEmail,
    this.createdAt,
    this.userImage,
    this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userName: json["userName"],
    userEmail: json["userEmail"],
    createdAt: json["createdAt"],
    userImage: json["userImage"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "userEmail": userEmail,
    "createdAt": createdAt,
    "userImage": userImage,
    "userId": userId,
  };
}