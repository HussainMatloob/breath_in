import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  String? userId;
  String? message;
  String? time;
  String? userImage;

  ChatModel({
    this.userId,
    this.message,
    this.time,
    this.userImage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    userId: json["userId"],
    message: json["message"],
    time: json["time"],
    userImage: json["userImage"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "message": message,
    "time": time,
    "userImage": userImage,
  };
}