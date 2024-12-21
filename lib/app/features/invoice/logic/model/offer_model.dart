import 'package:dots/core/utils/response_model.dart';
import 'package:equatable/equatable.dart';

class InvoicesModel extends ResponseModel {
  const InvoicesModel({
    this.data,
    super.message,
    super.success,
    super.status,
  });
  final InvoicesDataM? data;

  factory InvoicesModel.fromJson(Map<String, dynamic> json) => InvoicesModel(
        message: json['message'],
        success: json['success'],
        status: json['status'],
        data:
            json['data'] != null ? InvoicesDataM.fromJson(json['data']) : null,
      );

  @override
  List<Object?> get props => [data];
}

class InvoicesDataM extends Equatable {
  const InvoicesDataM({this.total, this.invoices});

  final num? total;
  final List<Invoices>? invoices;

  factory InvoicesDataM.fromJson(Map<String, dynamic> json) {
    return InvoicesDataM(
        total: json['total'],
        invoices: List<Invoices>.from(
          (json['invoices'] as List<dynamic>).map<Invoices>(
            (e) => Invoices.fromJson(e as Map<String, dynamic>),
          ),
        ));
  }

  @override
  List<Object?> get props => [total, invoices];
}

class Invoices extends Equatable {
  final int? operationNumber;
  final int? pointsNumber;
  final String? userPhone;
  final double? invoiceAmount;
  final String? time;
  final String? date;
  final String? pointValue;
  final String? paidBy;

  const Invoices({
    this.operationNumber,
    this.pointsNumber,
    this.userPhone,
    this.invoiceAmount,
    this.time,
    this.date,
    this.pointValue,
    this.paidBy
  });

  factory Invoices.fromJson(Map<String, dynamic> json) {
    return Invoices(
      operationNumber: json["operation_number"],
      pointsNumber: json["points_number"],
      userPhone: json["user_phone"],
      invoiceAmount: double.parse(json["invoice_amount"].toString()),
      time: json["time"],
      date: json["date"],
      pointValue: json["point_value"],
      paidBy: json['paid_by']
    );
  }

  @override
  List<Object?> get props => [
        operationNumber,
        pointsNumber,
        userPhone,
        invoiceAmount,
        time,
        date,
        pointValue,
      ];
}
