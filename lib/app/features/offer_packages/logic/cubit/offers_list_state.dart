// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'offers_list_cubit.dart';

class OffersListState extends Equatable {
  const OffersListState({
    this.offerDetails,
    this.data,
    this.message,
    this.offerParams = const OfferParams(),
    this.status = const ResponseStatus.initial(),
  });

  final OfferModel? data;
  final OfferDetailsDataM? offerDetails;
  final OfferParams offerParams;

  final String? message;
  final ResponseStatus status;

  @override
  List<Object?> get props => [message, status, data, offerDetails, offerParams];

  OffersListState copyWith({
    OfferModel? data,
    OfferDetailsDataM? offerDetails,
    OfferParams? offerParams,
    String? message,
    ResponseStatus? status,
  }) {
    return OffersListState(
      data: data ?? this.data,
      offerDetails: offerDetails ?? this.offerDetails,
      offerParams: offerParams ?? this.offerParams,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
