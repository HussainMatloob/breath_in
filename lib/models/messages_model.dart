import 'dart:convert';

MessagesModel messagesModelFromJson(String str) => MessagesModel.fromJson(json.decode(str));

String messagesModelToJson(MessagesModel data) => json.encode(data.toJson());

class MessagesModel {
  String? id;
  bool? isLive;
  String? senderId;
  String? receiverId;
  String? idCombination;
  String? message;
  String? messageType;

  MessagesModel({
    this.id,
    this.isLive,
    this.senderId,
    this.receiverId,
    this.idCombination,
    this.message,
    this.messageType,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json) => MessagesModel(
    id: json["id"],
    isLive: json["isLive"],
    senderId: json["senderId"],
    receiverId: json["receiverId"],
    idCombination: json["idCombination"],
    message: json["message"],
    messageType: json["messageType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isLive": isLive,
    "senderId": senderId,
    "receiverId": receiverId,
    "idCombination": idCombination,
    "message": message,
    "messageType": messageType,
  };
}
