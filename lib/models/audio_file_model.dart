import 'dart:convert';
AudioFileModel audioFileModelFromJson(String str) => AudioFileModel.fromJson(json.decode(str));
String audioFileModelToJson(AudioFileModel data) => json.encode(data.toJson());

class AudioFileModel {
  String? audioName;
  String? audioFile;
  String? userId;

  AudioFileModel({
    this.audioName,
    this.audioFile,
    this.userId,
  });

  factory AudioFileModel.fromJson(Map<String, dynamic> json) => AudioFileModel(
    audioName: json["audioName"],
    audioFile: json["audioFile"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "audioName": audioName,
    "audioFile": audioFile,
    "userId": userId,
  };
}

