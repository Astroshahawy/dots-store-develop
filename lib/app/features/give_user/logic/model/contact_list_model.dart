import 'dart:convert';

ContactListModel contactListModelFromJson(String str) =>
    ContactListModel.fromJson(json.decode(str));

class ContactListModel {
  ContactListModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  bool success;
  int status;
  String message;
  Data data;

  factory ContactListModel.fromJson(Map<String, dynamic> json) =>
      ContactListModel(
        success: json["success"] ?? false,
        status: json["status"] ?? 500,
        message: json["message"] ?? '',
        data: Data.fromJson(json["data"] ?? {}),
      );
}

class Data {
  Data({
    required this.phone,
    required this.email,
    required this.tiktok,
    required this.snapchat,
    required this.instgram,
    required this.twitter,
    required this.whatsapp,
    required this.lat,
    required this.lang,
    required this.vendorImage,
  });

  String phone;
  String email;
  String tiktok;
  String snapchat;
  String instgram;
  String twitter;
  String whatsapp;
  String lat;
  String lang;
  String vendorImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phone: json["phone"] ?? '',
        email: json["email"] ?? '',
        tiktok: json["tiktok"] ?? '',
        snapchat: json["snapchat"] ?? '',
        instgram: json["instgram"] ?? '',
        twitter: json["twitter"] ?? '',
        whatsapp: json["whatsapp"] ?? '',
        lat: json["lat"] ?? '',
        lang: json["lang"] ?? '',
        vendorImage: json["vendor_image"] ?? '',
      );
}
