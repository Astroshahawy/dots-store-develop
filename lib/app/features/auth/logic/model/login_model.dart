import 'package:dots/core/utils/response_model.dart';
import 'package:equatable/equatable.dart';

class LoginModel extends ResponseModel {
  const LoginModel({
    super.message,
    super.success,
    super.status,
    this.loginDataModel,
  });
  final LoginDataModel? loginDataModel;
  @override
  List<Object?> get props => [loginDataModel];
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json['success'],
        status: json['status'],
        message: json['message'],
        loginDataModel:
            json['data'] != null ? LoginDataModel.fromJson(json['data']) : null,
      );
}

class LoginDataModel extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? crNumber;
  final String? mobile;
  final String? address;
  final String? lat;
  final String? lang;
  final String? image;
  final Category? category;
  final String? token;
  const LoginDataModel(
      {this.id,
      this.name,
      this.email,
      this.crNumber,
      this.mobile,
      this.address,
      this.lat,
      this.lang,
      this.image,
      this.category,
      this.token});

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        crNumber,
        mobile,
        address,
        lat,
        lang,
        image,
        category,
        token
      ];

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        crNumber: json['cr_number'] as String?,
        mobile: json['mobile'] as String?,
        address: json['address'] as String?,
        lat: json['lat'] as String?,
        lang: json['lang'] as String?,
        image: json['image'] as String?,
        category: json['category'] != null
            ? Category.fromJson(json['category'])
            : null,
        token: json['token'] as String?,
      );
}

class Category extends Equatable {
  final int? id;
  final String? name;
  final String? image;

  const Category({this.id, this.name, this.image});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
      );

  @override
  List<Object?> get props => [id, name, image];
}
