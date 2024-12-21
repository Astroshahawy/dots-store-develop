import 'package:dartz/dartz.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/network_service.dart';
import '../../../give_user/logic/model/message_model_model.dart';
import '../model/employee_model.dart';

abstract class EmployeeRepo {
  Future<Either<Failure, MessageModel>> repo({
    required String name,
    required String mobile,
    required String password,
  });

  // Future<Either<Failure, MessageModel>> updateRepo({
  //   required String name,
  //   required String mobile,
  // });

  Future<Either<Failure, EmployeeModel>> getRepo();

  Future<Either<Failure, MessageModel>> deleteRepo(int id);
}

class EmployeeRepoImpl extends EmployeeRepo {
  EmployeeRepoImpl(this.network);
  final NetworkService network;

  @override
  Future<Either<Failure, MessageModel>> repo({
    required String name,
    required String mobile,
    required String password,
  }) async {
    try {
      final response = await network.post(
        ApiUrls.addEmployee,
        hasToken: true,
        data: {
          'name': name,
          'mobile': mobile,
          'password': password,
        },
      );
      return Right(MessageModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }

  @override
  Future<Either<Failure, EmployeeModel>> getRepo() async {
    try {
      final response = await network.get(
        ApiUrls.listEmployees,
        hasToken: true,
      );
      return Right(EmployeeModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }

  @override
  Future<Either<Failure, MessageModel>> deleteRepo(int id) async {
    try {
      final response = await network.delete(
        '${ApiUrls.deleteEmployee}/$id',
        hasToken: true,
      );
      return Right(MessageModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }
}
