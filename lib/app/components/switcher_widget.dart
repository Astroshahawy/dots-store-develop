import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SwitcherWidget extends StatelessWidget {
  const SwitcherWidget({
    Key? key,
    required this.firstElement,
    required this.secondElement,
    required this.onToggle,
    required this.initialLabelIndex,
  }) : super(key: key);
  final String firstElement;
  final String secondElement;
  final void Function(int?) onToggle;
  final int initialLabelIndex;
  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      initialLabelIndex: initialLabelIndex,
      curve: Curves.easeInQuad,
      minWidth: 80.0,
      cornerRadius: 20.0,
      minHeight: 30,
      activeBgColors: [
        [Theme.of(context).colorScheme.primary],
        const [Color.fromARGB(255, 180, 136, 6)]
      ],
      activeFgColor: Theme.of(context).colorScheme.onPrimary,
      inactiveBgColor: Colors.grey.shade300,
      inactiveFgColor: Colors.black,
      totalSwitches: 2,
      labels: [firstElement, secondElement],
      radiusStyle: true,
      onToggle: onToggle,
    );
  }
}
