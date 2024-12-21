import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/network_service.dart';
import '../blocs/login_bloc/login_bloc.dart';
import '../model/login_model.dart';
import '../model/logout_m_res.dart';

// class Error extends DioError{
//   Error({required super.requestOptions});

// }

abstract class AuthRepo {
  Future<Either<Failure, LoginModel>> login({
    required String phone,
    required String password,
    required LoginType loginType,
  });

  Future<Either<Failure, LogoutMRes>> logoutRepo();
}

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl(this.network);
  final NetworkService network;

  @override
  Future<Either<Failure, LoginModel>> login({
    required String phone,
    required LoginType loginType,
    required String password,
  }) async {
    // final deviceToken = await FirebaseMessaging.instance.getToken();
    String? deviceToken = '';
    if (Platform.isAndroid) {
      deviceToken = await FirebaseMessaging.instance.getToken();
    } else if (Platform.isIOS) {
      deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    }

    final Map<String, dynamic> data;
    String endPoint;

    if (loginType == LoginType.manager) {
      endPoint = ApiUrls.login;
      data = {
        'login': phone,
        'password': password,
        'device_token': '$deviceToken',
        // 'device_token': '',
      };
    } else {
      endPoint = ApiUrls.employeeLogin;
      data = {
        'mobile': phone,
        'password': password,
        // 'device_token': '',
        'device_token': '$deviceToken',
      };
    }

    try {
      final response = await network.post(endPoint, data: data);
      return Right(LoginModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }

  @override
  Future<Either<Failure, LogoutMRes>> logoutRepo() async {
    try {
      final response = await network.get(ApiUrls.logout, hasToken: true);

      return Right(LogoutMRes.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }
}
