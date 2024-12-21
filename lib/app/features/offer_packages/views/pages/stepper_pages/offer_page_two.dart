import 'dart:developer';

import 'package:dots/app/components/switcher_widget.dart';
import 'package:dots/app/features/offer_packages/logic/cubit/offers_list_cubit.dart';
import 'package:dots/core/utils/const_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../../core/enum/time_data.dart';
import '../../../../../components/round_card_widget.dart';
import '../../widgets/select_customers_number.dart';
import '../../widgets/select_date_offer.dart';
import 'offer_page_one.dart';

class OfferPageTwo extends HookWidget {
  const OfferPageTwo({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    // final myColors = Theme.of(context).extension<ColorTheme>();
    final currentNum = ValueNotifier<int>(0);
    final instance = context.read<OffersListCubit>();
    instance.setOfferDetails = instance.offerDetails.copyWith(
      minimumPurchasePrice:
          (instance.offerDetails.dotsPackage!.price! * 2).toString(),
    );
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            GP.g24(),
            Form(
              key: formKey,
              child: TextFormField(
                textAlign: TextAlign.right,
                initialValue:
                    '${instance.offerDetails.dotsPackage!.price! * 2}',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'requiered_field_string'.tr();
                  }
                  if (int.tryParse(value)! <
                      (instance.offerDetails.dotsPackage!.price! + 10)) {
                    return '${'pack_validation_str'.tr()} ${instance.offerDetails.dotsPackage!.price! + 10} ${'sar'.tr()}';
                  }
                  if (int.tryParse(value)! >
                      (instance.offerDetails.dotsPackage!.price! * 2)) {
                    return '${'pack_validation_str'.tr()} ${instance.offerDetails.dotsPackage!.price! * 2} ${'sar'.tr()}';
                    // return '${'pack_validation_str_more'.tr()} ${instance.offerDetails.dotsPackage!.price! * 2} ${'sr_string'.tr()}';
                  }
                  return null;
                  // if (value == null || value.isEmpty) {
                  //   return 'requiered_field_str'.tr();
                  // }
                  // if (int.tryParse(value)! <
                  //     (instance.offerDetails.dotsPackage!.price! * 2)) {
                  //   return '${'pack_validation_str'.tr()} ${instance.offerDetails.dotsPackage!.price! * 2} ${'sr_str'.tr()}';
                  // }
                  // return null;
                },
                onChanged: (value) {
                  instance.setOfferDetails = instance.offerDetails.copyWith(
                    minimumPurchasePrice: value,
                  );
                  formKey.currentState!.validate();
                  // _formKey.currentState?.validate();
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade600,
                      width: 1,
                    ),
                  ),
                  // focusedBorder: InputBorder.none,
                  // errorBorder: InputBorder.none,
                  icon: RoundCardWidget(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 9),
                      borderColor: Colors.grey.shade600,
                      child: Text("lowest_buying_price_str".tr())),
                  hintText: "50 ${'sr_str'.tr()}",
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  errorMaxLines: 2,
                ),
              ),
            ),
            GP.g24(),
            ValueListenableBuilder(
                valueListenable: currentNum,
                builder: (context, value, child) {
                  instance.setOfferDetails = instance.offerDetails.copyWith(
                    beneficiaries: slider[currentNum.value].toString(),
                    timing: TimeDate.pm,
                  );
                  return RoundCardWidget(
                    borderColor: Colors.grey.shade600,
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (ctx) => Container(
                          height: 220,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: SelectCustomersNumber((i) {
                            currentNum.value = i;
                          }),
                        ),
                      );
                    },
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("clients_num_str".tr()).textStyleGx(
                          context.titleMediumGx,
                        ),
                        Text(slider[currentNum.value])
                            .boldGx()
                            .textColorGx(context.schemeGx.primary),
                      ],
                    ),
                  );
                }),
            GP.g24(),
            RoundCardWidget(
              borderColor: Colors.grey.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("timing_str".tr()).textStyleGx(
                    context.titleMediumGx,
                  ),
                  SwitcherWidget(
                    firstElement: 'morning_str'.tr(),
                    secondElement: 'evening_str'.tr(),
                    onToggle: (int? d) {
                      log('$d');
                      final instance = context.read<OffersListCubit>();
                      instance.setOfferDetails = instance.offerDetails.copyWith(
                        timing: d == 0 ? TimeDate.am : TimeDate.pm,
                        date: DateFormat('yyyy-MM-dd', 'En')
                            .format(DateTime.now()),
                      );
                    },
                    initialLabelIndex: 1,
                  ),
                ],
              ),
            ),
            GP.g24(),
            SelectDateOffer((date) {
              final instance = context.read<OffersListCubit>();
              instance.setOfferDetails = instance.offerDetails.copyWith(
                date: date,
              );
            }),
          ],
        ),
      ),
    );
  }
}
