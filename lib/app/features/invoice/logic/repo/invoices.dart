import 'package:dartz/dartz.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/network_service.dart';
import '../model/offer_model.dart';

abstract class InvoicesRepo {
  Future<Either<Failure, InvoicesModel>> getUnpaidInvoices();
  Future<Either<Failure, InvoicesModel>> getPaidInvoices();
}

class InvoicesRepoImpl extends InvoicesRepo {
  InvoicesRepoImpl(this.network);
  final NetworkService network;

  @override
  Future<Either<Failure, InvoicesModel>> getUnpaidInvoices() async {
    try {
      final response = await network.get(ApiUrls.unpaidInvoice, hasToken: true);

      return Right(InvoicesModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }

  @override
  Future<Either<Failure, InvoicesModel>> getPaidInvoices() async {
    try {
      final response = await network.get(ApiUrls.paidInvoice, hasToken: true);

      return Right(InvoicesModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }
}
