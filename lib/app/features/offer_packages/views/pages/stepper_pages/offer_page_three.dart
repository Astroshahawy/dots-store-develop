import 'package:dots/core/utils/const_file.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../../../../../components/round_card_widget.dart';
import '../../../logic/cubit/offers_list_cubit.dart';
import '../../../logic/repo/offers.dart';

class OfferPageThree extends StatelessWidget {
  const OfferPageThree({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // logger.i(context.read<OffersListCubit>().getOfferDetails);
    final instance = context.read<OffersListCubit>().getOfferDetails;
    var offer = (instance.dotsPackage?.price)! *
        (int.tryParse(instance.beneficiaries!)! * 0.25);

    var tax = (instance.tax! / 100) * (offer);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('selected_pack_str'.tr()).boldGx(),
            GP.g8(),
            RoundCardWidget(
              // borderColor: Colors.grey.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Iconify(
                        Mdi.checkbox_marked_circle_outline,
                        size: 25,
                        color: context.themeGx.primaryColor,
                      ),
                      GP.g8(),
                      Text('${instance.dotsPackage?.title} (${instance.dotsPackage?.price})')
                          .textStyleGx(context.titleMediumGx)
                          .boldGx()
                          .textColorGx(context.themeGx.primaryColor),
                      GP.g8(),
                      Iconify(
                        Mdi.checkbox_marked_circle_outline,
                        size: 25,
                        color: context.themeGx.primaryColor,
                      ),
                    ],
                  ),
                  GP.g4(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${'clients_num_str'.tr()} :')
                          .textStyleGx(context.bodyMediumGx),
                      GP.g8(),
                      Text('${instance.beneficiaries}')
                          .textStyleGx(context.bodyMediumGx),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${'lowest_buying_price_str'.tr()} :')
                          .textStyleGx(context.bodyMediumGx),
                      GP.g8(),
                      Text(
                        instance.minimumPurchasePrice ?? '0',
                      ).textStyleGx(context.bodyMediumGx),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${'timing_str'.tr()} :')
                          .textStyleGx(context.bodyMediumGx),
                      GP.g8(),
                      Text(
                        '${instance.timing?.name} ',
                      ).textStyleGx(context.bodyMediumGx),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${'date_str'.tr()} :')
                          .textStyleGx(context.bodyMediumGx),
                      GP.g8(),
                      Text('${instance.date}')
                          .textStyleGx(context.bodyMediumGx),
                    ],
                  ),
                  // const Text('يتم منح كل عميل كاش باك عشان'),
                ],
              ),
            ),
            GP.g16(),
            Text('invoice_details_str'.tr()).boldGx(),
            GP.g8(),
            RoundCardWidget(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  TitleAndValueWidget(
                    title: 'total_customer_get'.tr(),
                    value:
                        "${int.parse(instance.beneficiaries!) * instance.dotsPackage!.price!} ${'sr_str'.tr()}",
                  ),
                  GP.g8(),
                  TitleAndValueWidget(
                    title: 'offer_value_str'.tr(),
                    value: "$offer ${'sr_str'.tr()}",
                  ),
                  GP.g8(),
                  TitleAndValueWidget(
                    title: 'tax_value_str'.tr(),
                    value: "${instance.tax}%",
                  ),
                  GP.g8(),
                  const Divider(),
                  TitleAndValueWidget(
                    title: 'total_discount_str'.tr(),
                    value: "${tax + offer} ${'sr_str'.tr()}",
                  ),
                  // const TitleAndValueWidget(
                  //   title: ' خصم دوتس ',
                  //   value: "50% ",
                  // ),
                  // const Divider(),
                  // TitleAndValueWidget(
                  //   title: 'الإجمالى',
                  //   value:
                  //       "${(instance.tax!) * (instance.dotsPackage!.price!) * (50 / 100)} ر.س",
                  // ),
                ],
              ),
            ),
            GP.g16(),
            Text('اختر وسيله الدفع'.tr()).boldGx(),
            GP.g8(),
            HookBuilder(builder: (context) {
              final paymentMethod = useState<PaymentMethod?>(null);
              return RoundCardWidget(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* InkWell(
                        onTap: () {
                          final instance = context.read<OffersListCubit>();
                          instance.setOfferDetails =
                              instance.offerDetails.copyWith(
                            paymentMethod: PaymentMethod.sadad,
                          );
                          paymentMethod.value = PaymentMethod.sadad;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color:
                                      paymentMethod.value == PaymentMethod.sadad
                                          ? context.schemeGx.primary
                                          : context.schemeGx.onPrimary,
                                  width: 2)),
                          child: const Text('Sadad').boldGx(),
                        ),
                      ), */
                      InkWell(
                        onTap: () {
                          final instance = context.read<OffersListCubit>();
                          instance.setOfferDetails =
                              instance.offerDetails.copyWith(
                            paymentMethod: PaymentMethod.byNinja,
                          );
                          paymentMethod.value = PaymentMethod.byNinja;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: paymentMethod.value ==
                                          PaymentMethod.byNinja
                                      ? context.schemeGx.primary
                                      : context.schemeGx.onPrimary,
                                  width: 2)),
                          child: const Text('نينجا').boldGx(),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          final instance = context.read<OffersListCubit>();
                          instance.setOfferDetails =
                              instance.offerDetails.copyWith(
                            paymentMethod: PaymentMethod.visa,
                          );
                          paymentMethod.value = PaymentMethod.visa;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: paymentMethod.value == PaymentMethod.visa
                                    ? context.schemeGx.primary
                                    : context.schemeGx.onPrimary,
                                width: 2),
                          ),
                          child: const Text('Visa').boldGx(),
                        ),
                      ),
                    ],
                  ));
            })
          ],
        ),
      ),
    );
  }
}

class TitleAndValueWidget extends StatelessWidget {
  const TitleAndValueWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title).textStyleGx(context.bodyMediumGx),
        GP.g8(),
        Text(value).textStyleGx(context.bodyMediumGx),
      ],
    );
  }
}
