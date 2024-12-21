import 'dart:convert';

VendorIdModel ventorIdModelFromJson(String str) => VendorIdModel.fromJson(json.decode(str));


class VendorIdModel {
    bool success;
    int status;
    String message;
    List<VendorIdDatum> data;

    VendorIdModel({
        required this.success,
        required this.status,
        required this.message,
        required this.data,
    });

    factory VendorIdModel.fromJson(Map<String, dynamic> json) => VendorIdModel(
        success: json["success"]??false,
        status: json["status"]??404,
        message: json["message"]??'',
        data:json["data"]== null ? []: List<VendorIdDatum>.from(json["data"].map((x) => VendorIdDatum.fromJson(x))),
    );
}

class VendorIdDatum {
    int id;
    String name;
    String image;

    VendorIdDatum({
        required this.id,
        required this.name,
        required this.image,
    });

    factory VendorIdDatum.fromJson(Map<String, dynamic> json) => VendorIdDatum(
        id: json["id"]??0,
        name: json["name"]??'',
        image: json["image"]??'',
    );
}
