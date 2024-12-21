import 'dart:convert';

import 'package:dots/app/features/Wallet/Logic/profile_model.dart';
import 'package:dots/core/utils/local_storage/local_storage.dart';
import 'package:dots/core/utils/local_storage/storage_keys.dart';
import 'package:geeks_service/service/logger.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  int chargedValue = 0;
  changeChargedValue(int value) {
    chargedValue = value;
    update();
  }

  bool isLoading = false;
  ProfileModel? profileModel;

  //******Login call Apis */

  Future getProfileData() async {
    isLoading = true;
    update();
    await ProfileApis().getProfileDataApi().then((value) {
      if (value.isOk) {
        Map<String, dynamic> body = json.decode(value.bodyString.toString());

        logger.e(body.toString());

        if (body["success"]) {
          profileModel = ProfileModel.fromJson(body);
        } else {
          Get.snackbar('خطأ !!', body['msg']);
        }
      } else {
        Get.snackbar('خطأ !!', value.body['message']);
      }
    });
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }
}

class ProfileApis extends GetConnect {
  //********* Login api */
  Future<Response> getProfileDataApi() async {
    Response<dynamic>? response;

    try {
      logger.i("Login URL : ${'https://dotsapp.co/api/vendor/profile'}");
      // logger.i("Login URL : $token");
      logger.e("Login URL : ${Storage.getString(
        StorageAuthKeys.token,
      )}");

      response = await get(
        'https://dotsapp.co/api/vendor/profile',
        headers: {
          'Authorization': 'Bearer ${Storage.getString(
            StorageAuthKeys.token,
          )}',
          'Accept-Language': 'ar',
          'Connection': 'keep-alive',
          'Accept': '*/*'
        },
        contentType: 'application/json',
      );
    } catch (e) {
      logger.e(e.toString());
    }

    return response!;
  }
}
