// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

class ProfileModel {
  bool success;
  int status;
  String message;
  Data data;

  ProfileModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        success: json["success"] ?? false,
        status: json["status"] ?? 404,
        message: json["message"] ?? '',
        data: Data.fromJson(json["data"] ?? {}),
      );
}

class Data {
  int id;
  String type;
  String name;
  String email;
  String crNumber;
  String mobile;
  String address;
  String lat;
  String lang;
  String distance;
  List<Image> images;
  Category category;
  int wallet;

  Data({
    required this.id,
    required this.type,
    required this.name,
    required this.email,
    required this.crNumber,
    required this.mobile,
    required this.address,
    required this.lat,
    required this.lang,
    required this.distance,
    required this.images,
    required this.category,
    required this.wallet,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? 0,
        type: json["type"] ?? '',
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        crNumber: json["cr_number"] ?? '',
        mobile: json["mobile"] ?? '',
        address: json["address"] ?? '',
        lat: json["lat"] ?? '',
        lang: json["lang"] ?? '',
        distance: json["distance"] ?? '',
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        category: Category.fromJson(json["category"] ?? {}),
        wallet: json["wallet"] ?? 0,
      );
}

class Category {
  int id;
  String name;
  String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        image: json["image"] ?? "",
      );
}

class Image {
  String url;

  Image({
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"] ?? "",
      );
}
