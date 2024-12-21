import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geeks_service/service/response_status.dart';

import '../../../../../core/network/fails_method.dart';
import '../../../give_meal/logic/model/message_model_model.dart';
import '../model/cashback_offer_model.dart';
import '../repo/cashback_repo.dart';

part 'cashback_offer_state.dart';

class CashbackOfferCubit extends Cubit<CashbackOfferState> {
  CashbackOfferCubit(this.cashbackOffer) : super(const CashbackOfferState());
  final CashbackOfferRepo cashbackOffer;

  void getOffers(int? statusId) async {
    emit(state.copyWith(status: const ResponseStatus.loading()));
    final response = await cashbackOffer.getOffers(statusId);
    response.fold(
      (failure) =>
          fail(failure, (data) => emit(data), const CashbackOfferState()),
      (success) => emit(state.copyWith(
          status: const ResponseStatus.success(), data: success)),
    );
  }

  void confirmCashbackOffer(int id) async {
    emit(state.copyWith(confirmStatus: const ResponseStatus.loading()));
    final response = await cashbackOffer.confirmCashbackOffer(id);

    response.fold(
      (failure) =>
          fail(failure, (data) => emit(data), const CashbackOfferState()),
      (success) {
        
      emit(state.copyWith(
          confirmStatus: const ResponseStatus.success(),
          messageModel: success,
          message: success.message));
      }
    );
  }
}
