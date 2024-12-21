import 'package:dots/app/components/image_net.dart';
import 'package:dots/core/utils/const_file.dart';
import 'package:flutter/material.dart';

class PaymentMethodsTap extends StatelessWidget {
  const PaymentMethodsTap({
    Key? key,
    required this.paymentImg,
    required this.title,
    required this.onChanged,
    required this.value,
    required this.selectedValue,
  }) : super(key: key);
  final String paymentImg;
  final String title;
  final void Function(int?) onChanged;
  final int value;
  final ValueNotifier<int?> selectedValue;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.only(top: 15),
      child: RadioListTile<int>(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            GP.g16(),
            ImageNet(
              paymentImg,
              height: 55,
              width: 55,
            ),
          ],
        ),
        value: value,
        groupValue: selectedValue.value,
        onChanged: onChanged,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        tileColor: Theme.of(context).colorScheme.background,
        selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
        activeColor: Theme.of(context).colorScheme.primary,
        selected: value == selectedValue.value,
      ),
    );
  }
}
