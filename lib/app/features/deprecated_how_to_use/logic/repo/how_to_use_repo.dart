// import 'package:dartz/dartz.dart';
// import 'package:dots/app/features/how_to_use/logic/model/how_to_use_m_res.dart';
// import 'package:geeks_service/geeks_service.dart';

// import '../../../../../core/network/api_urls.dart';
// import '../../../../../core/network/network_service.dart';

// abstract class HowToUseRepo {
//   Future<Either<Failure, HowToUseMRes>> howToUseRepo();
// }

// class HowToUseRepoImpl extends HowToUseRepo {
//   HowToUseRepoImpl(this.network);
//   final NetworkService network;

//   @override
//   Future<Either<Failure, HowToUseMRes>> howToUseRepo() async {
//     try {
//       final response = await network.get(
//         ApiUrls.staticPages,
//       );
//       return Right(HowToUseMRes.fromJson(response.data));
//     } on DioError catch (e) {
//       return Left(Failure.fromCode(e));
//     }
//   }
// }
