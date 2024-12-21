import 'package:dots/app/components/custom_toast_w.dart';
import 'package:dots/core/route/routes.dart';
import 'package:dots/core/utils/const_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:geeks_service/geeks_service.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/ph.dart';
// Import for Android features.
// Import for iOS features.

import '../../../../../core/enum/time_data.dart';
import '../../../pay_c.dart';
import '../../logic/cubit/cashback_offer_cubit.dart';
import '../../logic/model/cashback_offer_model.dart';

enum Status {
  review("review"),
  accepted("accepted"),
  rejected("rejected");

  final String status;
  const Status(this.status);
}

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({super.key, required this.cashbackOfferItem});
  final CashbackOfferData cashbackOfferItem;
  @override
  Widget build(BuildContext context) {
    const secureStorage = FlutterSecureStorage();

    final TimeDate timeDate =
        cashbackOfferItem.timing == 1 ? TimeDate.am : TimeDate.pm;
    return Card(
      color: context.schemeGx.background,
      margin: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('تم إرسال الباقة التالية')
                      .boldGx()
                      .textColorGx(context.schemeGx.primary),
                ),
                GP.g16(),
                Row(
                  children: [
                    Flexible(
                        child: _CardWidget(
                      title: 'سعر الباقة',
                      valueTitle: "${cashbackOfferItem.price} ر.س",
                      icon: Healthicons.money_bag_outline,
                    )),
                    GP.g16(),
                    Flexible(
                        child: _CardWidget(
                      title: 'عدد العملاء :',
                      valueTitle: "${cashbackOfferItem.beneficiaries}",
                      icon: FluentMdl2.people,
                    )),
                  ],
                ),
                GP.g16(),
                _CardWidget(
                  title: ' كاش باك :',
                  valueTitle: "${cashbackOfferItem.cashback}",
                  icon: Ph.money,
                ),
                GP.g16(),
                Row(
                  children: [
                    _CardWidget(
                      title: 'تاريخ العرض :',
                      valueTitle:
                          "${cashbackOfferItem.date} / ${timeDate.name} ",
                      icon: Ph.timer,
                    ),
                    GP.g16(),
                  ],
                ),
                GP.g16(),
                if (cashbackOfferItem.status == Status.accepted.status)
                  BlocConsumer<CashbackOfferCubit, CashbackOfferState>(
                    listener: (context, state) {
                      if (state.confirmStatus ==
                          const ResponseStatus.success()) {
                        toast('${state.message}', success: true);
                      } else if (state.confirmStatus ==
                          const ResponseStatus.error()) {
                        toast('${state.message}');
                      }
                    },
                    builder: (context, state) {
                      return state.confirmStatus ==
                              const ResponseStatus.loading()
                          ? const Center(child: CupertinoActivityIndicator())
                          : MaterialButton(
                              onPressed: () async {
                                await secureStorage
                                    .read(key: 'vendorId')
                                    .then((value) {
                                  context.push(PayC(
                                    url:
                                        'https://dotsapp.co/pay_invoice_price?cash_back_offer_id=${cashbackOfferItem.id}&brand=VISA&vendor_id=$value',
                                  ));
                                });
                              },

                              // context
                              //     .read<CashbackOfferCubit>()
                              //     .confirmCashbackOffer(
                              //         cashbackOfferItem.id!);

                              color: context.schemeGx.primary,
                              child: const Text('تأكيد نشر الباقة')
                                  .textColorGx(context.schemeGx.onPrimary),
                            );
                    },
                  ),
                GP.g8(),
              ],
            ),
          ),
          if (cashbackOfferItem.status == Status.accepted.status)
            const Positioned(
              top: 10,
              left: 10,
              child: _ChipWidget(label: 'منشور', color: Colors.green),
            ),
          if (cashbackOfferItem.status == Status.rejected.status)
            const Positioned(
              top: 10,
              left: 10,
              child: _ChipWidget(label: 'ملغى', color: Colors.red),
            ),
          if (cashbackOfferItem.status == Status.review.status)
            const Positioned(
              top: 10,
              left: 10,
              child: _ChipWidget(label: 'مراجعه', color: Colors.orange),
            ),
          // if (cashbackOfferItem == Status.done)
          //   const Align(
          //     alignment: Alignment.topLeft,
          //     child: _ChipWidget(
          //       label: 'انتهت',
          //       color: Colors.grey,
          //     ),
          //   ),
        ],
      ),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.valueTitle,
  }) : super(key: key);
  final String icon;
  final String title;
  final String valueTitle;
  @override
  Widget build(BuildContext context) {
    const double fontSize = 12;
    return Row(
      children: [
        Row(
          children: [
            Iconify(
              icon,
              size: 25,
              color: context.schemeGx.primary,
            ),
            GP.g4(),
            Text(title).textStyleGx(context.bodyLargeGx).fontSizeGx(fontSize),
            // .textColorGx(Colors.red),
          ],
        ),
        GP.g8(),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: context.schemeGx.primaryContainer.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text(valueTitle).fontSizeGx(fontSize))),
      ],
    );
  }
}

class _ChipWidget extends StatelessWidget {
  const _ChipWidget({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: EdgeInsets.zero,
      label: Text(label).fontSizeGx(13),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w900,
        color: color,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      backgroundColor: color.withOpacity(0.1),
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      shape: StadiumBorder(
        side: BorderSide(color: color),
      ),
    );
  }
}
