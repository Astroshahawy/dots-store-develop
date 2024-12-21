// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/network_service.dart';
import '../model/message_model_model.dart';

abstract class GiveUserRepo {
  Future<Either<Failure, MessageModel>> givePoints({
    required String phone,
    required String amount,
  });
  Future<Either<Failure, MessageModel>> giveBalance({
    required String phone,
    required String amount,
  });
  
}

class GiveUserRepoImpl extends GiveUserRepo {
  GiveUserRepoImpl(this.network);
  final NetworkService network;

  @override
  Future<Either<Failure, MessageModel>> givePoints({
    required String phone,
    required String amount,
  }) async {
    try {
      final response = await network.post(
        ApiUrls.givePoints,
        hasToken: true,
        data: {
          'phone': phone,
          'amount': amount,
        },
      );
      return Right(MessageModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }

  @override
  Future<Either<Failure, MessageModel>> giveBalance({
    required String phone,
    required String amount,
  }) async {
    try {
      final response = await network.post(
        ApiUrls.giveBalance,
        hasToken: true,
        data: {
          'phone': phone,
          'amount': amount,
        },
      );

      return Right(MessageModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }
}
