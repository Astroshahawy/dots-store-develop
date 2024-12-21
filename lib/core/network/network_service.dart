import 'package:dots/core/network/api_urls.dart';
import 'package:geeks_service/geeks_service.dart';
import 'package:geeks_service/service/logger.dart';

abstract class NetworkService {
  get(
    String path, {
    Map<String, dynamic> queryParameters,
    bool hasToken = false,
  });
  post(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool hasToken,
    Map<String, dynamic> data,
  });
  delete(
    String path, {
    Map<String, dynamic> queryParameters,
    bool hasToken = false,
  });
  put(
    String path, {
    Map<String, dynamic> queryParameters,
    bool hasToken = false,
    Map<String, dynamic> data,

  });
}

class NetworkServiceImpl extends NetworkService {
  NetworkServiceImpl(this.dio);
  final Dio dio;

  var headers = {ApiUrls.keyHeaderToken: true};
  
  @override
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool hasToken = false,
    Map<String, dynamic> header = const {},
  }) async {
    Map<String, dynamic> headerData = {...header};
    if (hasToken) {
      headerData[ApiUrls.keyHeaderToken] = true;
    }
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient dioClient) {
    //   dioClient.badCertificateCallback =
    //       ((X509Certificate cert, String host, int port) => true);
    //   return dioClient;
    // };
    return dio.get(
      path,
      options: Options(headers: headerData),
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool hasToken = false,
    Map<String, dynamic>? data,
    Map<String, dynamic> header = const {},
  }) {
    Map<String, dynamic> headerData = {...header};
    if (hasToken) {
      headerData[ApiUrls.keyHeaderToken] = true;
    }
    headerData.logI('Header Data');
    data!.logI("Data");
    return dio.post(
      path,
      options: Options(headers: headerData),
      data: data,
      queryParameters: queryParameters,
    );
  }

  @override
  delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool hasToken = false,
    Map<String, dynamic>? data,
    Map<String, dynamic> header = const {},
  }) {
    Map<String, dynamic> headerData = {...header};
    if (hasToken) {
      headerData[ApiUrls.keyHeaderToken] = true;
    }
    return dio.delete(
      path,
      options: Options(headers: headerData),
      queryParameters: queryParameters,
    );
  }

  @override
  put(
      String path, {
    Map<String, dynamic>? queryParameters,
    bool hasToken = false,
    Map<String, dynamic>? data,
    Map<String, dynamic> header = const {},
  }) {
    Map<String, dynamic> headerData = {...header};
    if (hasToken) {
      headerData[ApiUrls.keyHeaderToken] = true;
    }
     return dio.put(
      path,
      options: Options(headers: headerData),
      queryParameters: queryParameters,
      data: data
    );
  }
}
