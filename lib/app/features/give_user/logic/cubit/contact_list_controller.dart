import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dots/app/features/give_user/logic/model/contact_list_model.dart';

class ContactListController extends GetxController {
  bool isLoading = false;
  ContactListModel? contactListModel;

  Future getData() async {
    isLoading = true;
    update();
    try {
      await MyController().getAdsDataApi().then((value) {
        if (value.statusCode == 200) {
          var body = json.decode(value.bodyString.toString());
          contactListModel = ContactListModel.fromJson(body);
        }
      });
      isLoading = false;
      update();
      /* await dio.get('https://dotsapp.co/api/contact-list').then((value) {
        if (value.statusCode == 200) {
          contactListModel = ContactListModel.fromJson(value.data);
          debugPrint(value.data);
          isLoading = false;
          update();
        } else {}
      }); */
    } catch (e) {
      isLoading = false;
      Get.snackbar('False', e.toString());
      debugPrint(e.toString());
      update();
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}

class MyController extends GetConnect {
  Future<Response> getAdsDataApi() async {
    Response<dynamic>? response;
    try {
   response=   await get(
        'https://dotsapp.co/api/contact-list',
      );
    } catch (e) {
      Get.snackbar(
        'False',
        e.toString(),
      );

      Get.defaultDialog(title: "$e");
    }
    return response!;
  }
}
