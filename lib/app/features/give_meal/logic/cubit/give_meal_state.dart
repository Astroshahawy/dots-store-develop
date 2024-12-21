part of 'give_meal_cubit.dart';

class GiveMealState extends Equatable {
  const GiveMealState({
    this.data,
    this.message,
    this.phonePoints,
    this.status = const ResponseStatus.initial(),
  });

  final MessageModel? data;
  final String? message;
  final ResponseStatus status;
  final String? phonePoints;

  GiveMealState copyWith({
    MessageModel? data,
    String? message,
    ResponseStatus? status,
    String? phonePoints,
  }) {
    return GiveMealState(
      phonePoints: phonePoints ?? this.phonePoints,
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
