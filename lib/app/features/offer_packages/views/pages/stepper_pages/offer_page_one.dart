import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots/app/features/offer_packages/logic/cubit/offers_list_cubit.dart';
import 'package:dots/app/features/offer_packages/logic/model/offer_model.dart';
import 'package:dots/core/network/wrap_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../../../../../../core/theme/color_theme.dart';

final slider = List.generate(10, (i) => (60 * (i + 1)).toString());

class OfferPageOne extends HookWidget {
  const OfferPageOne({
    this.height,

    // this.slider,
    super.key,
  });
  final double? height;

  @override
  Widget build(BuildContext context) {
    context.read<OffersListCubit>().getOffers();
    final myColors = Theme.of(context).extension<ColorTheme>();

    return BlocBuilder<OffersListCubit, OffersListState>(
      builder: (context, state) {
        final List<DotsPackage> offer = state.data?.data?.dotsPackage ?? [];
        return WrapService(
          status: state.status,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: HookBuilder(builder: (context) {
              final page = useState<int>(offer.length ~/ 2);
              final instance = context.read<OffersListCubit>();
              instance.setOfferDetails = instance.offerDetails.copyWith(
                  tax: int.tryParse(state.data!.data!.tax!),
                  packageId: offer[page.value].id.toString(),
                  percentage: state.data?.data?.percentage.toString(),
                  offerData: offer[page.value]);
              return CarouselSlider.builder(
                options: CarouselOptions(
                  // height: 300,
                  viewportFraction: 0.32,
                  // autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.easeInOutCirc,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.vertical,
                  disableCenter: true,
                  enableInfiniteScroll: false,
                  initialPage: offer.length ~/ 2,
                  onPageChanged: (i, CarouselPageChangedReason e) {
                    page.value = i;
                  },
                ),
                itemCount: offer.length,
                itemBuilder: (context, index, realIndex) {
                  final isSelectedColor = page.value == index
                      ? myColors?.colorScheme.onPrimaryContainer
                      : myColors?.colorScheme.outline;
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: page.value == index
                            ? myColors!.colorScheme.primary
                            : context.themeGx.focusColor,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // color: Colors.red,
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Iconify(
                              Mdi.checkbox_marked_circle_outline,
                              size: 22,
                              color: page.value == index
                                  ? myColors?.colorScheme.primary
                                  : context.themeGx.focusColor,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${offer[index].title}')
                                .textStyleGx(context.titleLargeGx)
                                .boldGx()
                                .textColorGx(isSelectedColor!),
                            Text('${offer[index].price}')
                                .textStyleGx(context.headlineMedium)
                                .boldGx()
                                .textColorGx(isSelectedColor),
                            Text('${offer[index].description}')
                                .textColorGx(isSelectedColor),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        );
      },
    );
  }
}
