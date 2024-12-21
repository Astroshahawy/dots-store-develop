import 'package:dots/app/features/Wallet/View/Widgets/paymeny_method_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/utils/const_file.dart';

class SelectPaymentMethod extends HookWidget {
  const SelectPaymentMethod({
    Key? key,
    required this.onSelect,
    required this.paymentMethodsList,
  }) : super(key: key);

  final List<PaymentMethods> paymentMethodsList;
  final void Function(String selected) onSelect;

  @override
  Widget build(BuildContext context) {
    final paymentMethods = useState<String?>(null);

    return Row(
      children: [
        for (final i in paymentMethodsList)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  paymentMethods.value = i.name;
                  onSelect(i.name);
                },
                child: Container(
                  height: 70,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: paymentMethods.value == i.name
                        ? context.schemeGx.outline.withOpacity(.05)
                        : context.schemeGx.outline.withOpacity(.01),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: paymentMethods.value == i.name
                          ? context.schemeGx.primary.withOpacity(.5)
                          : context.schemeGx.background,
                    ),
                  ),
                  child: Pd.p8(
                    child: SvgPicture.asset(
                      i.image,
                      height: 35,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
