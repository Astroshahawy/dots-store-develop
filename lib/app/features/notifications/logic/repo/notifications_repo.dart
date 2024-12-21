import 'package:dartz/dartz.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/network_service.dart';
import '../model/notification_model.dart';

abstract class NotificationsRepo {
  Future<Either<Failure, NotificationsModel>> getRepo();
}

class NotificationsRepoImpl implements NotificationsRepo {
  NotificationsRepoImpl(this.dioWebServer);
  final NetworkService dioWebServer;

  @override
  Future<Either<Failure, NotificationsModel>> getRepo() async {
    try {
      final response =
          await dioWebServer.get(ApiUrls.notifications, hasToken: true);

      return Right(NotificationsModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }
}
