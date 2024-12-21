import 'package:geeks_service/geeks_service.dart';
import 'package:geeks_service/service/logger.dart';

import '../../../../app/features/auth/logic/model/login_model.dart';
import '../local_storage.dart';
import '../storage_keys.dart';

mixin UserInfoStorage {
  static void saveLocalUserInfo(
    LoginModel loginModel,
    FlutterSecureStorage secureStorage,
  ) {
    final LoginDataModel uInfo = loginModel.loginDataModel!;
    logger.w(uInfo);
    logger.e('uInfo phone ${uInfo.mobile}');
    logger.e('uInfo name ${uInfo.name}');
    logger.e('uInfo image = ${uInfo.image}');
    logger.e('uInfo Token = ${uInfo.token}');

    secureStorage.write(key: 'token', value: uInfo.token);
    secureStorage.write(key: 'vendorId', value: uInfo.id.toString());

    if (uInfo.name != null) {
      Storage.putString(
        StorageAuthKeys.nameSTR,
        uInfo.name!,
      );
    }

    Storage.putString(
      StorageAuthKeys.phoneSTR,
      uInfo.mobile!,
    );

    if (uInfo.image != null) {
      Storage.putString(
        StorageAuthKeys.imageSTR,
        uInfo.image!,
      );
    }
    if (uInfo.email != null) {
      Storage.putString(
        StorageAuthKeys.emailSTR,
        uInfo.email!,
      );
    }
  }
}
