import 'package:flutter/material.dart';
import 'package:geeks_service/service/logger.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebviewPage extends StatelessWidget {
  const PaymentWebviewPage({
    super.key,
    required this.paymentUrl,
  });
  final String paymentUrl;

  @override
  Widget build(BuildContext context) {
    logger.i(paymentUrl);
    TextTheme textTheme = context.textTheme;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'الدفع',
            style: TextStyle(
              color: textTheme.bodyMedium!.color,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
            ),
            onPressed: () => Get.back(),
            color: Colors.black,
          )),
      body: GetBuilder<PaymentController>(
        init: PaymentController(paymentUrl),
        builder: (_) {
          return _.loading < 100
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.grey.withOpacity(0.3),
                          color: Colors.red, strokeWidth: 25,
                          value: _.loading / 100,
                          semanticsValue: _.loading.toString(),
                          valueColor: Animation.fromValueListenable(
                              ValueNotifier(
                                  context.theme.appBarTheme.backgroundColor)),
                          // color: orangColorFC6011,
                        ),
                      ),
                      Text(
                        '\n\n${_.loading.toString()} %',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              : SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: WebViewWidget(
                    controller: _.controller,
                  ),
                );
        },
      ),
    );
  }
}

class PaymentController extends GetxController {
  final String url;
  late WebViewController controller;
  double loading = 0;

  PaymentController(this.url);
  @override
  void onInit() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(orangColorFC6011)

      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            printInfo(info: progress.toString());
            loading = progress.toDouble();
            update();
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            logger.d(request.url, 'Current');
            if (request.url.contains('success')) {
              logger.d('success');
              Get.back();
              Get.back();

              return NavigationDecision.prevent;
            } else if (request.url.contains('fail')) {
              logger.w('fail');
              Get.back();
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith('https://www.google.com/')) {
              logger.i(request);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    super.onInit();
  }
}
