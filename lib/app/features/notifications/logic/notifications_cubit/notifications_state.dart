part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.status = const ResponseStatus.initial(),
    this.data = const [],
    this.message = '',
  });

  final ResponseStatus status;
  final String message;
  final List<NotificationM> data;

  NotificationsState copyWith({
    ResponseStatus? status,
    List<NotificationM>? data,
    String? message,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  List<Object> get props => [data, status, message];
}
