import 'package:dots/core/utils/response_model.dart';
import 'package:equatable/equatable.dart';

class OfferModel extends ResponseModel {
  const OfferModel({
    this.data,
    super.message,
    super.success,
    super.status,
  });
  final OfferDataM? data;

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        message: json['message'],
        success: json['success'],
        status: json['status'],
        data: OfferDataM.fromJson(json['data'] as Map<String, dynamic>),
      );

  @override
  List<Object?> get props => [data];
}

class OfferDataM extends Equatable {
  const OfferDataM({
    this.tax,
    this.percentage,
    this.dotsPackage,
  });
  final String? tax;
  final String? percentage;

  final List<DotsPackage>? dotsPackage;

  factory OfferDataM.fromJson(Map<String, dynamic> json) {
    return OfferDataM(
      tax: json['tax'],
      percentage: json['percentage'],
      dotsPackage: List<DotsPackage>.from(
        (json['dots_package'] as List<dynamic>).map<DotsPackage>(
          (e) => DotsPackage.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [tax, percentage, dotsPackage];
}

class DotsPackage extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final int? price;

  const DotsPackage({
    this.id,
    this.title,
    this.description,
    this.price,
  });

  factory DotsPackage.fromJson(Map<String, dynamic> json) {
    return DotsPackage(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
    );
  }

  @override
  List<Object?> get props => [id, title, description, price];
}
