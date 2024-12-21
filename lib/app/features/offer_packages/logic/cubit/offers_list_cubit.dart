import 'package:bloc/bloc.dart';
import 'package:dots/app/features/offer_packages/logic/repo/offers.dart';
import 'package:equatable/equatable.dart';
import 'package:geeks_service/geeks_service.dart';
import 'package:geeks_service/service/logger.dart';

import '../../../../../../core/network/fails_method.dart';
import '../model/offer_details_model.dart';
import '../model/offer_model.dart';

part 'offers_list_state.dart';

class OffersListCubit extends Cubit<OffersListState> {
  OffersListCubit(this.offersRepo) : super(const OffersListState());
  final OffersRepo offersRepo;
  OfferParams offerDetails = const OfferParams();

  set setOfferDetails(OfferParams offerDetails) =>
      this.offerDetails = offerDetails;

  OfferParams get getOfferDetails => offerDetails;

  void getOffers() async {
    emit(state.copyWith(status: const ResponseStatus.loading()));
    final product = await offersRepo.getOffers();
    product.fold(
      (failure) => fail(failure, (data) => emit(data), const OffersListState()),
      (success) => emit(state.copyWith(
          status: const ResponseStatus.success(), data: success)),
    );
  }

  Future postOffersDate() async {
    emit(state.copyWith(status: const ResponseStatus.loading()));
    '$offerDetails'.logWtf();
    final product = await offersRepo.postOffersDate(offerDetails);
    product.fold(
        (failure) =>
            fail(failure, (data) => emit(data), const OffersListState()),
        (success) {
      if (success.success == false && success.message != null) {
        emit(state.copyWith(
            status: const ResponseStatus.error(), message: success.message));
      } else {
        emit(state.copyWith(
            status: const ResponseStatus.success(),
            offerDetails: success.data));
      }
    });
  }
}
