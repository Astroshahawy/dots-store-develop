part of 'give_user_cubit.dart';

class GiveUserState extends Equatable {
  const GiveUserState({
    this.data,
    this.message,

    this.status = const ResponseStatus.initial(),
  });

  final MessageModel? data;
  final String? message;
  final ResponseStatus status;


  GiveUserState copyWith({
    MessageModel? data,
    String? message,
    ResponseStatus? status,
    String? phonePoints,
    String? amountPoints,
    String? phoneBalance,
    String? amountBalance,
  }) {
    return GiveUserState(

      data: data ?? this.data,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
        data,

      ];
}
