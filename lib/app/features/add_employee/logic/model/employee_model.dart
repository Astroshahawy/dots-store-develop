import 'package:dots/core/utils/response_model.dart';
import 'package:equatable/equatable.dart';

class EmployeeModel extends ResponseModel {
  const EmployeeModel({
    this.data,
    super.message,
    super.success,
    super.status,
  });
  final List<EmployeeDataM>? data;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        message: json['message'],
        success: json['success'],
        status: json['status'],
        data: List<EmployeeDataM>.from(
          (json['data'] as List<dynamic>).map<EmployeeDataM>(
            (e) => EmployeeDataM.fromJson(e as Map<String, dynamic>),
          ),
        ),
      );

  @override
  List<Object?> get props => [data];
}

class EmployeeDataM extends Equatable {
  final int? id;
  final String? name;
  final String? mobile;

  const EmployeeDataM({
    this.id,
    this.name,
    this.mobile,
  });

  factory EmployeeDataM.fromJson(Map<String, dynamic> json) {
    return EmployeeDataM(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
    );
  }

  @override
  List<Object?> get props => [id, name, mobile];
}
