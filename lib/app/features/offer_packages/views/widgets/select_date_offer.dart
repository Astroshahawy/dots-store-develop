import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../components/round_card_widget.dart';
import 'date_picker.dart';

class SelectDateOffer extends HookWidget {
  const SelectDateOffer(
    this.changed, {
    Key? key,
  }) : super(key: key);
  final Function(String) changed;

  @override
  Widget build(BuildContext context) {
    final selectedDate = useState<String?>(
      DateFormat('yyyy-MM-dd' , 'en').format(
        DateTime.now(),
      ),
    );
    changed(selectedDate.value!);

    return RoundCardWidget(
      borderColor: Colors.grey.shade600,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      onTap: () async {
        await showDatePickerFun(context).then((value) {
          selectedDate.value = value;
          return selectedDate.value;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("date_str".tr()).textStyleGx(
            context.titleMediumGx,
          ),
          Text(selectedDate.value!)
              .boldGx()
              .textColorGx(context.schemeGx.primary),
        ],
      ),
    );
  }
}
