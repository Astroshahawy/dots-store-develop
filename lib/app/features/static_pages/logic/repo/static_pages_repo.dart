import 'package:dartz/dartz.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/network_service.dart';
import '../model/static_pages_m_res.dart';

abstract class StaticPagesRepo {
  Future<Either<Failure, StaticPagesMRes>> staticPagesRepo(
    String pageType,
  );
}

class StaticPagesRepoImpl extends StaticPagesRepo {
  StaticPagesRepoImpl(this.network);
  final NetworkService network;

  @override
  Future<Either<Failure, StaticPagesMRes>> staticPagesRepo(
    String pageType,
  ) async {
    try {
      final response = await network.get(
        ApiUrls.staticPages,
        hasToken: true,
        queryParameters: <String, String>{
          'key': pageType,
        },
      );
      return Right(StaticPagesMRes.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }
}
