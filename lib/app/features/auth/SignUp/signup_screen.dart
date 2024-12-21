import 'dart:convert';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart' as dio;
import 'package:dots/app/components/loading_widget.dart';
import 'package:dots/app/features/auth/SignUp/text_field_border.dart';
import 'package:dots/app/features/auth/logic/model/vendor_id_model.dart';
import 'package:easy_localization/easy_localization.dart' as loc;
import 'package:flutter/material.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geeks_service/service/logger.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

import '../../../../core/utils/assets_file.dart';
import '../../../components/Map/map_components/map_component.dart';
import 'text_field_custom.dart';

class SignUpScreeen extends StatelessWidget {
  SignUpScreeen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SignUpCollectData signUpCollectData = SignUpCollectData();
    String address = '';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: SvgPicture.asset(
          AssetsFile.svg('logo2.svg'),
          color: context.themeGx.colorScheme.surface,
          height: 25,
        ),
      ),
      body: GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (_) {
          return SizedBox(
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              loc.tr("login_str"),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "مرحباً بك",
                              // style:
                              //     TextStyle(fontSize: 18, color: Colors.white),
                            )
                          ],
                        ),
                        const Spacer(),
                        Stack(
                          // fit: StackFit.passthrough,
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: _.mainServiceImage == null
                                  ? const AssetImage("assets/images/splash.png")
                                      as ImageProvider
                                  : FileImage(_.mainServiceImage),
                              radius: 40,
                            ),
                            Positioned(
                                right: -15,
                                bottom: -10,
                                child: IconButton(
                                  onPressed: () {
                                    // openImagePicker(
                                    //     context: context,
                                    //     onCameraTapped: () {
                                    //       _.getAddProfilePic(
                                    //         ImageSource.camera,
                                    //       );
                                    //     },
                                    //     onGalleryTapped: () {
                                    //       _.getAddProfilePic(
                                    //         ImageSource.gallery,
                                    //       );
                                    //     });
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    // color: orangeColor,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: context.heightGx * .05),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.deepPurple, width: 4),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: <Widget>[
                            TextFiledAuthentication(
                              icon: Icons.person,
                              label: "Name in Arabic",
                              onSave: (_) {
                                signUpCollectData.nameAr = _;
                              },
                              validatorFunction: (_) {
                                return null;
                              },
                            ),
                            TextFiledAuthentication(
                              icon: Icons.person,
                              label: 'Name in English',
                              onSave: (_) {
                                signUpCollectData.nameEn = _;
                              },
                              validatorFunction: (_) {
                                return null;
                              },
                            ),
                            TextFiledAuthentication(
                              // isPassword: false,
                              // isLogin: true,
                              icon: Icons.file_copy_outlined,
                              label: 'CR Number',
                              onSave: (_) {
                                signUpCollectData.crNo = _;
                              },
                              validatorFunction: (_) {
                                return null;
                              },
                            ),
                            TextFiledAuthentication(
                              label: 'Mobile',
                              icon: Icons.phone,
                              // isLogin: true,
                              onSave: (_) {
                                signUpCollectData.mobile = _;
                              },
                              validatorFunction: (_) {
                                return null;
                              },
                            ),
                            TextFiledAuthentication(
                              label: 'Email',
                              isEmail: true,
                              icon: Icons.email_outlined,
                              onSave: (_) {
                                signUpCollectData.email = _;
                              },
                              validatorFunction: (_) {
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 15, bottom: 15),
                              child: DropdownButtonFormField<int>(
                                  decoration: inputDecoration(),
                                  hint: const Text('Vendor Category Id'),
                                  items: _.vendorItems,
                                  onChanged: (value) {
                                    logger.d(value);
                                    signUpCollectData.vendorCategoryId =
                                        value.toString();
                                  }),
                            ),
                            GetBuilder<MapController>(
                              init: MapController(),
                              builder: (mapController) {
                                return InkWell(
                                  onTap: () {
                                    Get.dialog(const MapPickerWidget());
                                  },
                                  child: TextFiledAuthentication(
                                    isEnabeled: false,
                                    isPassword: false,
                                    icon: Icons.location_on,
                                    label: 'Address',
                                    onSave: (_) {
                                      signUpCollectData.address = _;
                                      signUpCollectData.lat = mapController
                                          .position.latitude
                                          .toString();
                                      signUpCollectData.lng = mapController
                                          .position.longitude
                                          .toString();
                                    },
                                    textEditingController:
                                        mapController.mapInputController,
                                    validatorFunction: (_) {
                                      return null;
                                    },
                                  ),
                                );
                              },
                            ),
                            TextFiledAuthentication(
                              isPassword: true,
                              label: 'Password',
                              icon: Icons.lock,
                              onSave: (_) {
                                signUpCollectData.password = _;
                              },
                              validatorFunction: (_) {
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 15, bottom: 15),
                              child: DropdownButtonFormField<int>(
                                hint: const Text('Region Id'),
                                items: const [
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text(
                                      "alawaly",
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text(
                                      "النزهه",
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 4,
                                    child: Text(
                                      "الشوقيه",
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 5,
                                    child: Text(
                                      "الشرايع",
                                    ),
                                  )
                                ],
                                onChanged: (value) {
                                  signUpCollectData.regionId = value.toString();
                                  logger.i(value, "from regions");
                                },
                                decoration: inputDecoration(),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _.chooseStartTime(context);
                                _.update();
                              },
                              child: TextFiledAuthentication(
                                isEnabeled: false,
                                textEditingController:
                                    _.eventStartTimeController,
                                label: 'Start of working hour',
                                icon: Icons.access_time,
                                onSave: (_) {
                                  signUpCollectData.startOfWork = _;
                                },
                                validatorFunction: (_) {
                                  return null;
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _.chooseEndTime(context);
                                _.update();
                              },
                              child: TextFiledAuthentication(
                                isEnabeled: false,
                                textEditingController: _.eventEndTimeController,
                                label: 'End of working hour',
                                icon: Icons.access_time_outlined,
                                onSave: (_) {
                                  signUpCollectData.endOfWork = _;
                                },
                                validatorFunction: (_) {
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 15, bottom: 15),
                              child: DropdownButtonFormField<int>(
                                decoration: inputDecoration(),
                                hint: const Text('Type Of Service'),
                                items: const [
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text('Receipt'),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text('Delivery'),
                                  ),
                                  DropdownMenuItem(
                                    value: 3,
                                    child: Text('Receipt and delivery'),
                                  ),
                                ],
                                onChanged: (value) {
                                  signUpCollectData.typeOfService =
                                      value.toString();
                                  logger.i(value);
                                },
                              ),
                            ),
                            TextFiledAuthentication(
                              label: 'Minimum order Value',
                              icon: Icons.bar_chart_rounded,
                              onSave: (_) {
                                signUpCollectData.minimumOrderValue = _;
                              },
                              validatorFunction: (_) {
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 15, bottom: 15),
                              child: DropdownButtonFormField<int>(
                                decoration: inputDecoration(),
                                hint: const Text('Type Of '),
                                items: const [
                                  DropdownMenuItem(
                                    value: 1,
                                    child: Text('Internal'),
                                  ),
                                  DropdownMenuItem(
                                    value: 2,
                                    child: Text('External'),
                                  ),
                                ],
                                onChanged: (value) {
                                  signUpCollectData.type = value.toString();
                                  logger.i(value);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _.isLoading
                                ? const LoadingWidget()
                                : ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        logger.w(address);
                                        signUpCollectData.image =
                                            _.mainServiceImage;
                                        _.postSignUpFunction(signUpCollectData);
                                      }
                                    },
                                    child: Text(loc.tr('confirmed'))),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SignUpController extends GetxController {
  dynamic mainServiceImage;
  // final picker = ImagePicker();
  TextEditingController eventStartTimeController = TextEditingController();
  TextEditingController eventEndTimeController = TextEditingController();
  List<DropdownMenuItem<int>> vendorItems = [];
  void chooseStartTime(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    ).then((value) {
      logger.i("${value!.hour}:${value.minute}");
      eventStartTimeController =
          TextEditingController(text: "${value.hour}:${value.minute}");
      printInfo(info: eventStartTimeController.text);
      update();
    });
  }

  void chooseEndTime(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    ).then((value) {
      logger.i("${value!.hour}:${value.minute}");
      eventEndTimeController =
          TextEditingController(text: "${value.hour}:${value.minute}");
      printInfo(info: eventEndTimeController.text);
      update();
    });
  }

  // void getAddProfilePic(ImageSource source) async {
  //   Get.focusScope!.unfocus();
  //   final pickedFile = await picker.pickImage(source: source);
  //   mainServiceImage = File(pickedFile!.path);
  //   update();
  //   Get.back();
  // }

  bool isLoading = false;
  Future<void> postSignUpFunction(
    SignUpCollectData collectData,
  ) async {
    logger.v(collectData.toJson());
    isLoading = true;
    update();
    await dio.Dio()
        .post('https://dotsapp.co/public/api/vendor/register',
            data: dio.FormData.fromMap(collectData.toJson()))
        .then((value) {
      logger.w(value.data);
      if (value.statusCode == 200) {
        Map<String, dynamic> body = json.decode(value.data.toString());
        isLoading = false;
        update();
        logger.i(body);
        Get.back();
        Get.snackbar('failed', body['messgae'].toString());
      } else {
        isLoading = false;
        update();
        Get.snackbar('failed', value.data['message'].toString());
      }
    });
    isLoading = false;
    update();
  }

  bool isVendorLoading = false;
  late VendorIdModel vendorIdModel;
  Future<void> getVendorCategoryIdFunction() async {
    isVendorLoading = true;
    update();
    await dio.Dio()
        .get(
      'https://dotsapp.co/public/api/user/vendor-category-list',
    )
        .then((value) {
      logger.i(value.data);
      if (value.statusCode == 200) {
        // Map<String, dynamic> body = json.decode(value.data);
        vendorIdModel = VendorIdModel.fromJson(value.data);
        vendorItems.clear();
        for (var element in vendorIdModel.data) {
          vendorItems.add(DropdownMenuItem<int>(
            value: element.id,
            child: Text(element.name),
          ));
        }
        isVendorLoading = false;
        update();
      } else {
        isVendorLoading = false;
        update();
        Get.snackbar('failed', value.data['message'].toString());
      }
    });
    isVendorLoading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    getVendorCategoryIdFunction();
  }
}

class SignUpCollectData {
  String? nameAr;
  String? nameEn;
  String? crNo;
  String? email;
  String? mobile;
  String? regionId;
  String? lat;
  String? lng;
  String? address;
  String? password;
  String? vendorCategoryId;
  String? startOfWork;
  String? endOfWork;
  String? typeOfService;
  String? minimumOrderValue;
  String? type;
  dynamic image;
  SignUpCollectData({
    this.lat,
    this.address,
    this.mobile,
    this.regionId,
    this.lng,
    this.password,
    this.image,
    this.crNo,
    this.email,
    this.endOfWork,
    this.minimumOrderValue,
    this.nameAr,
    this.nameEn,
    this.startOfWork,
    this.type,
    this.typeOfService,
    this.vendorCategoryId,
  });

  Map<String, dynamic> toJson() => {
        "name_ar": nameAr,
        "name_en": nameEn,
        "cr_number": crNo,
        "mobile": mobile,
        "email": email,
        "vendor_category_id": vendorCategoryId,
        "address": address,
        "lat": lat,
        "lang": lng,
        "password": password,
        "images": image is File
            ? dio.MultipartFile.fromFile(image!.path,
                filename: path.basename(image!.path))
            : null,
        "region_id": regionId,
        "start_of_working_hours": startOfWork,
        "end_of_working_hours": endOfWork,
        "type_of_services": typeOfService,
        "minimum_order_value": minimumOrderValue,
        "type": type,
      };
}
