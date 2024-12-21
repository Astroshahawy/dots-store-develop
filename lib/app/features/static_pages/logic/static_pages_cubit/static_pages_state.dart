part of 'static_pages_cubit.dart';

class StaticPagesState extends Equatable {
  const StaticPagesState({
    this.status = const ResponseStatus.initial(),
    this.data = const [],
  });

  final ResponseStatus status;
  final List<StaticPagesM> data;

  StaticPagesState copyWith({
    ResponseStatus? status,
    List<StaticPagesM>? data,
  }) {
    return StaticPagesState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  @override
  List<Object> get props => [status, data];
}
