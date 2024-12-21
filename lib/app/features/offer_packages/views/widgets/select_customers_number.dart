import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots/core/utils/const_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/theme/color_theme.dart';
import '../pages/stepper_pages/offer_page_one.dart';

class SelectCustomersNumber extends HookWidget {
  const SelectCustomersNumber(
    this.onNumberChanged, {
    super.key,
  });
  final void Function(int val) onNumberChanged;

  @override
  Widget build(BuildContext context) {
    final ColorTheme? myColors = Theme.of(context).extension<ColorTheme>();
    final currentNum = useState<int>(0);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          GP.g24(),
          SizedBox(
            // height: 160,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: 120,
                viewportFraction: 0.1,
                // autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.easeInOutCirc,
                enlargeCenterPage: true,
                // scrollDirection: Axis.vertical,
                // disableCenter: true,
                onPageChanged: (i, CarouselPageChangedReason e) {
                  onNumberChanged(i);
                  currentNum.value = i;
                  // logger.w(currentNum.value);
                },
              ),
              itemCount: slider.length,
              itemBuilder: (context, index, realIndex) {
                return SizedBox(
                  // color: Colors.green,
                  // width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: currentNum.value == index
                      ? Text(slider[index])
                          .textStyleGx(
                            context.titleLargeGx,
                          )
                          .textColorGx(myColors!.colorScheme.primary)
                      : Text(slider[index]).textStyleGx(
                          context.titleMediumGx,
                        ),
                );
              },
            ),
          ),
          Expanded(
              child: Text('${slider[currentNum.value]} ${'client_str'.tr()}')
                  .textStyleGx( 
                    context.titleMediumGx,
                  )
                  .textColorGx(myColors!.colorScheme.primary)
              // .boldGx(),
              ),
          GP.g40(),
        ],
      ),
    );
  }
}
