import 'package:equatable/equatable.dart';

import '../../../../../core/utils/response_model.dart';

class NotificationsModel extends ResponseModel {
  const NotificationsModel({
    this.data = const [],
    super.message,
    super.status,
    super.success,
  });
  final List<NotificationM> data;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        success: json["success"],
        message: json['message'],
        status: json['status'],
        data: json['data'] == null
            ? []
            : List<NotificationM>.from(
                (json['data'] as List<dynamic>).map<NotificationM>(
                  (e) => NotificationM.fromJson(e as Map<String, dynamic>),
                ),
              ),
      );

  @override
  List<Object?> get props => [data];
}

class NotificationM extends Equatable {
  const NotificationM({
    this.title = '',
    this.message = '',
    // this.read = '',
    // this.createdAt = '',
    required this.id,
  });

  final int id;
  final String title;
  final String message;
  // final String read;
  // final String createdAt;

  factory NotificationM.fromJson(Map<String, dynamic> json) => NotificationM(
        id: json['id'],
        title: json['title'],
        message: json['content'] ?? '',
        // read: json['read'],
        // createdAt: json['created_at'],
      );

  @override
  List<Object?> get props => [
        title,
        message,
        // read,
        id,
        // createdAt,
      ];
}
