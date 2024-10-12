import 'dart:convert';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
  String? videoName;
  String? videoFile;
  String? userId;

  VideoModel({
    this.videoName,
    this.videoFile,
    this.userId,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    videoName: json["videoName"],
    videoFile: json["videoFile"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "videoName": videoName,
    "videoFile": videoFile,
    "userId": userId,
  };
}


