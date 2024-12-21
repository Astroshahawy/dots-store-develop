import 'package:dots/app/components/custom_toast_w.dart';
import 'package:dots/app/components/loading_widget.dart';
import 'package:dots/app/components/lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../auth/logic/blocs/send_verify_code_controller.dart';

class PinCodeScreen extends StatelessWidget {
  final String phoneNo;
  const PinCodeScreen(this.phoneNo, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: GetBuilder<PinCodeController>(
          init: PinCodeController(phoneNo),
          builder: (_) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                right: 5,
                left: 5,
                top: 100,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                        child: LottieWidget(
                            lottie:
                                'assets/lotties/phone-number-verification.json')),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'الرجاء إدخال رمز التحقق',
                      style: TextStyle(
                        fontFamily: 'Shamel',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'الرجاء التحقق من رقم الهاتف $phoneNo لمتابعة الدخول للتطبيق ',
                      style: const TextStyle(
                        fontFamily: 'Shamel',
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: PinCodeTextField(
                        onCompleted: (value) {
                          if (value == _.verifyCodeModel!.data.toString()) {
                            _.sendVerifyCodeApi(phoneNo, value);
                          } else {
                            toast('غير متطابق');
                          }
                          // context.pushName(RouteName.homePage);
                        },
                        appContext: context,
                        enabled: !_.isVerify,
                        length: 4,
                        backgroundColor: Colors.transparent,
                        onChanged: (String value) {},
                        animationType: AnimationType.fade,
                        animationDuration: const Duration(milliseconds: 300),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          inactiveColor: context.textThemeGx.bodyLarge!.color,
                          activeColor: const Color(0xFF42A5F5),

                          // selectedColor: ,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 60,
                          fieldWidth: 60,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text.rich(TextSpan(
                        text: 'للإرسال مرة أخري؟',
                        style: TextStyle(
                          fontFamily: 'Shamel',
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: " إضغط هنا",
                            style: TextStyle(
                              fontFamily: 'Shamel',
                              fontSize: 12,
                              color: Color(0xFF42A5F5),
                            ),
                          ),
                        ],
                      )),
                    ),
                    if (_.isVerify) const LoadingWidget()
                  ]),
            );
          },
        ),
      ),
    );
  }
}
