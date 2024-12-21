import 'dart:developer';

import 'package:dots/app/features/offer_packages/views/pages/stepper_pages/offer_page_three.dart';
import 'package:dots/app/features/offer_packages/views/pages/stepper_pages/offer_page_two.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geeks_service/service/logger.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geeks_service/geeks_service.dart';
import 'package:geeks_service/service/response_status.dart';

import '../../../../../injection/injection_container.dart';
import '../../../../components/custom_toast_w.dart';
import '../../../../components/loading_widget.dart';
import '../../../../components/no_network_dialog.dart';
import '../../logic/cubit/offers_list_cubit.dart';
import 'stepper_pages/offer_page_one.dart';

class OfferPackagesPage extends StatelessWidget {
  const OfferPackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => injector<OffersListCubit>(),
        child: const OfferPackagesView());
  }
}

class OfferPackagesView extends HookWidget {
  const OfferPackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    log('message');
    // final idOfferCtr = useTextEditingController();
    final page = ValueNotifier<int>(0);
    final pageController = usePageController();
    // const double paddingWithElevatedButton = 82.0; // paddings: 32
    const double bottomAppBar = 40.0;
    // final double totalSpaces = MediaQuery.of(context).padding.top +
    //     kToolbarHeight +
    //     bottomAppBar +
    //     paddingWithElevatedButton;
    // logger.w(totalSpaces);
    return ValueListenableBuilder(
      valueListenable: page,
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (page.value == 1 || page.value == 2) {
                pageController.animateToPage(page.value - 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              }
              if (page.value == 0) {
                Navigator.of(context).pop();
              }
            },
          ),
          centerTitle: true,
          title: Text('*${'offers_packs_str'.tr()}*'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(bottomAppBar),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('select_pack_str'.tr()).textColorGx(page.value == 0
                      ? context.schemeGx.primary
                      : Colors.black),
                  Text('duration_str'.tr()).textColorGx(page.value == 1
                      ? context.schemeGx.primary
                      : Colors.black),
                  Text('apply_order_str'.tr()).textColorGx(page.value == 2
                      ? context.schemeGx.primary
                      : Colors.black),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<OffersListCubit, OffersListState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == const ResponseStatus.noInternetC()) {
                serverErrorDialog(context);
              } else if (state.status == const ResponseStatus.error()) {
                toast('${state.message}', success: false);
              } else if (page.value == 2 &&
                  state.status == const ResponseStatus.success()) {
                toast('request_succesfull_str'.tr(), success: true);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  page.value.logV();
                  if (page.value == 0) {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOutCirc,
                    );
                  }
                  if (page.value == 1) {
                    if (formKey.currentState!.validate()) {
                      context
                              .read<OffersListCubit>()
                              .getOfferDetails
                              .isFillObject()
                          ? pageController.nextPage(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeInOutCirc,
                            )
                          : null;
                    }
                  }
                  if (page.value == 2) {
                    context.read<OffersListCubit>().postOffersDate();
                    // pageController.nextPage(
                    //   duration: const Duration(milliseconds: 800),
                    //   curve: Curves.easeInOutCirc,
                    // );
                  }
                },
                child: state.status == const ResponseStatus.loading()
                    ? const SizedBox(
                        height: 25,
                        width: 25,
                        child: LoadingWidget(),
                      )
                    : Text(page.value == 2
                        ? "send_order_str".tr()
                        : 'next_str'.tr()),
              );
            },
          ),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (int i) {
            page.value = i;
          },
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const OfferPageOne(),
            OfferPageTwo(formKey: formKey),
            const OfferPageThree(),
          ],
        ),
      ),
    );
  }
}
