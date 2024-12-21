// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/network_service.dart';
import '../model/message_model_model.dart';

abstract class GiveMealRepo {
  Future<Either<Failure, MessageModel>> giveMeal({
    required String phone,
  });
}

class GiveMealRepoImpl extends GiveMealRepo {
  GiveMealRepoImpl(this.network);
  final NetworkService network;

  @override
  Future<Either<Failure, MessageModel>> giveMeal({
    required String phone,
  }) async {
    try {
      final response = await network.post(
        ApiUrls.giveMeal,
        hasToken: true,
        data: {'phone': phone},
      );
      return Right(MessageModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }
}
