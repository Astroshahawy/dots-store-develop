import '../../../../../core/utils/response_model.dart';

class MessageModel extends ResponseModel {
  const MessageModel({
    super.message,
    super.success,
    super.status,
  });

  Map<String, dynamic> toJson() => {
        'success': success,
        'status': status,
        'message': message,
      };
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      success: json['success'] as bool,
      status: json['status'] as int,
      message: json['message'] as String,
    );
  }
}
