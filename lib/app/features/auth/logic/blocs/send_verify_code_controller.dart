import 'dart:developer';

import 'package:dots/app/features/auth/views/pages/login_page.dart';
import 'package:geeks_service/geeks_service.dart';
import 'package:get/get.dart';
import 'dart:convert';

class PinCodeController extends GetxController {
  final String phoneNo;

  PinCodeController(this.phoneNo);
  bool isSend = false;
  bool isVerify = false;
  VerifyCodeModel? verifyCodeModel;
  Dio dio = Dio();
  @override
  void onInit() {
    super.onInit();
    getVerifyCodeApi();
  }

  Future<void> getVerifyCodeApi() async {
    isSend = true;
    update();
    try {
      log("send verify code api : 'https://dotsapp.co/api/vendor/send-verify-code ");
      log("send verify number api : $phoneNo ");
      await dio.post('https://dotsapp.co/api/vendor/send-verify-code',
          data: {'verify_key': phoneNo}).then((value) {
        log('verify status code = ${value.statusCode}');
        if (value.statusCode == 200) {
          verifyCodeModel = VerifyCodeModel.fromJson(value.data);
          log(verifyCodeModel!.data.toString());
          // Get.offAll(PinCodeScreen(phoneNo: phoneNo , pinCode: verifyCodeModel!.data) , transition: Transition.noTransition);
          isSend = false;
          update();
        }
      });
    } catch (e) {
      isSend = false;
      update();
    }
  }

  Future<void> sendVerifyCodeApi(String phone, String pinCode) async {
    isVerify = true;
    update();

    try {
      log(" verify code api : 'https://dotsapp.co/api/vendor/verify-account ");

      await dio.post('https://dotsapp.co/api/vendor/verify-account',
          data: {'verify_key': phone, 'otp': pinCode}).then((value) {
        if (value.statusCode == 200) {
          verifyCodeModel = VerifyCodeModel.fromJson(value.data);
          log(verifyCodeModel!.data.toString());
          Get.offAll(const LoginPage(), transition: Transition.noTransition);
          isVerify = false;
          update();
        }
      });
    } catch (e) {
      isVerify = false;
      update();
    }
  }
}

VerifyCodeModel verifyCodeModelFromJson(String str) =>
    VerifyCodeModel.fromJson(json.decode(str));

class VerifyCodeModel {
  VerifyCodeModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  bool success;
  int status;
  String message;
  int data;

  factory VerifyCodeModel.fromJson(Map<String, dynamic> json) =>
      VerifyCodeModel(
        success: json["success"] ?? false,
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
        data: json["data"] ?? 0,
      );
}
