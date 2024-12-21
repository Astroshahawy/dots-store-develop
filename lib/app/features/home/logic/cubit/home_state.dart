part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.data,
    this.message,
    this.status = const ResponseStatus.loading(),
  });

  final SliderHomeDateM? data;
  final String? message;
  final ResponseStatus status;

  @override
  List<Object?> get props => [message, status, data];

  HomeState copyWith({
    SliderHomeDateM? data,
    String? message,
    ResponseStatus? status,
  }) {
    return HomeState(
      data: data ?? this.data,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
