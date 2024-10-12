import 'dart:convert';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  String? imageName;
  String? imageFile;
  String? userId;

  ImageModel({
    this.imageName,
    this.imageFile,
    this.userId,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    imageName: json["imageName"],
    imageFile: json["imageFile"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "imageName": imageName,
    "imageFile": imageFile,
    "userId": userId,
  };
}
