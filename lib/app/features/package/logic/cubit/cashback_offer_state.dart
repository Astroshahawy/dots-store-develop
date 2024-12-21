part of 'cashback_offer_cubit.dart';

class CashbackOfferState extends Equatable {
  const CashbackOfferState({
    this.data,
    this.message,
    this.messageModel,
    this.status = const ResponseStatus.loading(),
    this.confirmStatus = const ResponseStatus.initial(),
  });

  final CashbackOfferModel? data;
  final MessageModel? messageModel;
  final String? message;
  final ResponseStatus status;
  final ResponseStatus confirmStatus;

  @override
  List<Object?> get props => [
        message,
        status,
        data,confirmStatus,messageModel,
      ];

  CashbackOfferState copyWith({
    CashbackOfferModel? data,
    String? message,
    ResponseStatus? status,
    ResponseStatus? confirmStatus,
    MessageModel? messageModel,
  }) {
    return CashbackOfferState(
      data: data ?? this.data,
      messageModel: messageModel ?? this.messageModel,
      message: message ?? this.message,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      status: status ?? this.status,
    );
  }
}
