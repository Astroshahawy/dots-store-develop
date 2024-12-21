import 'package:dots/l10n/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';

class SlideWidget extends StatelessWidget {
  const SlideWidget({
    super.key,
    required this.valueSelect,
    required this.onValueChanged,
  });
  final int valueSelect;
  final void Function(int?) onValueChanged;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: SizedBox(
        width: double.infinity,
        child: CupertinoSlidingSegmentedControl<int>(
          thumbColor: context.schemeGx.surfaceTint,
          // padding: const EdgeInsets.symmetric(vertical: 5),
          backgroundColor: ElevationOverlay.colorWithOverlay(
              context.schemeGx.surface, context.schemeGx.primary, 3.0),
          onValueChanged: onValueChanged,
          groupValue: valueSelect,
          children: <int, Widget>{
            0: const Text(LocaleKeys.currentPackage).tr().textColorGx(
                valueSelect == 0
                    ? context.schemeGx.background
                    : context.schemeGx.onSurfaceVariant),
            1: const Text(LocaleKeys.EndedPackage).tr().textColorGx(
                valueSelect == 1
                    ? context.schemeGx.background
                    : context.schemeGx.onSurfaceVariant),
          },
        ),
      ),
    );
  }
}
