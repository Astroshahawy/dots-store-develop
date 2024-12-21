import 'package:dots/injection/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geeks_service/service/logger.dart';

import '../../../../../core/network/wrap_service.dart';
import '../../logic/cubit/cashback_offer_cubit.dart';
import '../widgets/card_item_widget.dart';

enum StatusPackage {
  all("all"),
  review("review", 1),
  accepted("accepted", 2),
  confirmed("confirmed", 3),
  rejected("rejected", 4);
  // canceled("canceled", 5);

  final String status;
  final int? id;
  const StatusPackage(
    this.status, [
    this.id,
  ]);
}

List<String> tabNames = [
  'all'.tr(),
  'review'.tr(),
  'accepted'.tr(),
  'confirmed'.tr(),
  'rejected'.tr(),
];

class SubscribePackages extends HookWidget {
  const SubscribePackages({super.key});

  @override
  Widget build(BuildContext context) {
    final page = ValueNotifier<int>(0);
    final pageController = usePageController(initialPage: 0);
    // var selectedValue = useState<int>(0);
    return Scaffold(
      appBar: AppBar(
        title: Text('shared_pack_str'.tr()),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                height: 30,
                child: ListView.builder(
                  cacheExtent: context.widthGx * .2,
                  scrollDirection: Axis.horizontal,
                  itemCount: tabNames.length,
                  itemBuilder: (context, index) {
                    return ValueListenableBuilder(
                        valueListenable: page,
                        builder: (context, value, child) => InkWell(
                              onTap: () {
                                pageController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                                page.value = index;
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: page.value == index
                                          ? Colors.black38
                                          : Colors.transparent,
                                      shape: BoxShape.rectangle),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(tabNames[index]).textColorGx(
                                          page.value == index
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ));
                  },
                ),
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: PageView(
          controller: pageController,
          // onPageChanged: (int i) {
          //   page.value = i;
          // },
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            StatusPackage.values.length,
            (index) => PackageItem(statusPackage: StatusPackage.values[index]),
          ),
        ),
      ),
    );
  }
}

class PackageItem extends StatelessWidget {
  const PackageItem({super.key, required this.statusPackage});
  final StatusPackage statusPackage;
  @override
  Widget build(BuildContext context) {
    logger.wtf("$statusPackage" ' ' '${statusPackage.id}');
    return BlocProvider(
        create: (context) =>
            injector<CashbackOfferCubit>()..getOffers(statusPackage.id),
        child: const PackageItemView());
  }
}

class PackageItemView extends StatelessWidget {
  const PackageItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CashbackOfferCubit, CashbackOfferState>(
      builder: (context, state) {
        final List listCashbackOffer = state.data?.data ?? [];
        return WrapService(
          status: state.status,
          child: listCashbackOffer.isEmpty
              ? Center(
                  child: Text('prev_pack_str'.tr()),
                )
              : ListView.builder(
                  itemCount: listCashbackOffer.length,
                  itemBuilder: (context, index) => CardItemWidget(
                      cashbackOfferItem: listCashbackOffer[index]),
                ),
        );
      },
    );
  }
}
