import 'package:dots/app/features/invoice/logic/cubit/invoice_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../stepper_pages/invoice_page_two.dart';

class InvoicePage extends HookWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final page = useState<int>(0);
    final pageController = usePageController(initialPage: 0);
    // const double paddingWithElevatedButton = 82.0; // paddings: 32
    const double bottomAppBar = 40.0;
    context.read<InvoiceCubit>().getInvoicesPaid();
    // final double totalSpaces = MediaQuery.of(context).padding.top +
    //     kToolbarHeight +
    //     bottomAppBar +
    //     paddingWithElevatedButton;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('my_invoices_str'.tr()),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(bottomAppBar),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // InkWell(
                //   onTap: () {
                //     page.value = 0;
                //     context.read<InvoiceCubit>().getInvoicesUnpaid();
                //   },
                //   child: Text('unpaid_inv_str'.tr()).textColorGx(page.value == 0
                //       ? context.schemeGx.primary
                //       : context.schemeGx.tertiary),
                // ),
                InkWell(
                  onTap: () {
                    page.value = 1;
                  },
                  child: Text('payment_history_str'.tr()).textColorGx(
                      page.value == 1
                          ? context.schemeGx.primary
                          : context.schemeGx.tertiary),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const PaidPageTwo(),
        // child: PageView(
        //   physics: const NeverScrollableScrollPhysics(),
        //   controller: pageController,
        //   onPageChanged: (int i) {
        //     page.value = i;
        //   },
        //   children: const [
        //     // UnPaidPageOne(),
        //     PaidPageTwo(),
        //   ],
        // ),
      ),
      // Padding(
      //   padding: const EdgeInsets.all(16),
      //   child: ElevatedButton(
      //     onPressed: () {
      //       if (page.value == 2) {
      //         Navigator.pop(context);
      //       }
      //       pageController.nextPage(
      //         duration: const Duration(milliseconds: 800),
      //         curve: Curves.easeInOutCirc,
      //       );
      //     },
      //     child: Text(page.value == 2 ? "ارسل الطلب" : 'التالي'),
      //   ),
      // ),
    );
  }
}
