import 'package:equatable/equatable.dart';

class ResponseModel extends Equatable {
  const ResponseModel({
    this.message,
    this.success,
    this.status,
  });
  final String? message;
  final bool? success;
  final int? status;

  @override
  List<Object?> get props => [message, success, status];
 
}
