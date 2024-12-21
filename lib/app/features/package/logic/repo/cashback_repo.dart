import 'package:dartz/dartz.dart';
import 'package:dots/app/features/give_meal/logic/model/message_model_model.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/network_service.dart';
import '../model/cashback_offer_model.dart';

abstract class CashbackOfferRepo {
  Future<Either<Failure, CashbackOfferModel>> getOffers(int? status);
  Future<Either<Failure, MessageModel>> confirmCashbackOffer(int id);
}

class CashbackOfferImpl extends CashbackOfferRepo {
  CashbackOfferImpl(this.network);
  final NetworkService network;
  @override
  Future<Either<Failure, CashbackOfferModel>> getOffers(int? status) async {
    try {
      final response = await network.get(ApiUrls.cashbackOffers,
          queryParameters: {"status": status}, hasToken: true);
      return Right(CashbackOfferModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }

  @override
  Future<Either<Failure, MessageModel>> confirmCashbackOffer(
      int id) async {
    try {
      final response = await network.post(
        ApiUrls.confirmCashbackOffer,
        data: {"cashback_offer_id": id},
        hasToken: true,
      );
      return Right(MessageModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }
}
