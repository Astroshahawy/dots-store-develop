import 'package:equatable/equatable.dart';

import '../../../../../core/utils/response_model.dart';

class CashbackOfferModel extends ResponseModel {
  const CashbackOfferModel({
    this.data,
    super.message,
    super.success,
    super.status,
  });
  final List<CashbackOfferData>? data;

  factory CashbackOfferModel.fromJson(Map<String, dynamic> json) =>
      CashbackOfferModel(
        success: json['success'] as bool,
        status: json['status'] as int,
        message: json['message'] as String,
        data: json['data'] != null
            ? (json['data'] as List)
                .map((e) =>
                    CashbackOfferData.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
      );
}

class CashbackOfferData extends Equatable {
  const CashbackOfferData(
      {this.id,
      this.description,
      this.beneficiaries,
      this.timing,
      this.date,
      this.price,
      this.cashback,
      this.vendorId,
      this.status});
  final int? id;
  final String? description;
  final int? beneficiaries;
  final int? timing;
  final String? date;
  final int? price;
  final int? cashback;
  final String? status;
  final int? vendorId;

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
        vendorId,
      ];

  factory CashbackOfferData.fromJson(Map<String, dynamic> json) =>
      CashbackOfferData(
        id: json['id'] as int,
        description: json['description'] as String?,
        beneficiaries: json['beneficiaries'] as int?,
        timing: json['timing'] as int?,
        date: json['date'] as String?,
        price: json['price'] as int?,
        cashback: json['cashback'] as int?,
        status: json['status'] as String?,
        vendorId: json['vendor_id'] ?? 0
      );
}
