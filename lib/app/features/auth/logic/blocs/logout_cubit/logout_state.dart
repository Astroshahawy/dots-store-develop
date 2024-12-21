part of 'logout_cubit.dart';


class LogoutState extends Equatable {
  const LogoutState({
    this.status = const ResponseStatus.initial(),
    this.message = '',
  });
  final ResponseStatus status;
  final String message;

  LogoutState copyWith({
    ResponseStatus? status,
    String? message,
  }) {
    return LogoutState(
      status: status ?? this.status,
      message: message ?? this.message,
      // -- : -- ?? this.--,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}