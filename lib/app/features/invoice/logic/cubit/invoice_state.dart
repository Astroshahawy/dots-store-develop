part of 'invoice_cubit.dart';



 class InvoiceState extends Equatable {

  const InvoiceState({
    this.data,
    this.message,
    this.status = const ResponseStatus.loading(),
  });

  final InvoicesModel? data;
  final String? message;
  final ResponseStatus status;

  @override
  List<Object?> get props => [
        message,
        status,
        data,
      ];

  InvoiceState copyWith({
    InvoicesModel? data,
    String? message,
    ResponseStatus? status,
  }) {
    return InvoiceState(
      data: data ?? this.data,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}

