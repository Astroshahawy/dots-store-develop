// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/response_model.dart';

class OfferDetailsModel extends ResponseModel {
  const OfferDetailsModel({
    this.data,
    super.message,
    super.success,
    super.status,
  });
  final OfferDetailsDataM? data;

  Map<String, dynamic> toJson() => {
        'success': success,
        'status': status,
        'message': message,
        'data': data!.toJson(),
      };
  factory OfferDetailsModel.fromJson(Map<String, dynamic> json) {
    return OfferDetailsModel(
      success: json['success'] as bool,
      status: json['status'] as int,
      message: json['message'] as String,
      data: json['data'] != null
          ? OfferDetailsDataM.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  List<Object?> get props => [data];
}

class OfferDetailsDataM extends Equatable {
  const OfferDetailsDataM(
      {this.id,
      this.description,
      this.beneficiaries,
      this.timing,
      this.date,
      this.price,
      this.cashback,
      this.status,
      F});
  final int? id;
  final dynamic description;
  final String? beneficiaries;
  final String? timing;
  final String? date;
  final int? price;
  final int? cashback;
  final String? status;

  @override
  List<Object?> get props => [
        id,
        description,
        beneficiaries,
        timing,
        date,
        price,
        cashback,
        status,
      ];
  factory OfferDetailsDataM.fromJson(Map<String, dynamic> json) =>
      OfferDetailsDataM(
        id: json['id'],
        description: json['description'],
        beneficiaries: json['beneficiaries'],
        timing: json['timing'].toString(),
        date: json['date'],
        price: json['price'],
        cashback: json['cashback'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'beneficiaries': beneficiaries,
        'timing': timing,
        'date': date,
        'price': price,
        'cashback': cashback,
        'status': status,
      };

  OfferDetailsDataM copyWith({
    int? id,
    dynamic description,
    String? beneficiaries,
    String? timing,
    String? date,
    int? price,
    int? cashback,
    String? status,
  }) {
    return OfferDetailsDataM(
      id: id ?? this.id,
      description: description ?? this.description,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      timing: timing ?? this.timing,
      date: date ?? this.date,
      price: price ?? this.price,
      cashback: cashback ?? this.cashback,
      status: status ?? this.status,
    );
  }
}
