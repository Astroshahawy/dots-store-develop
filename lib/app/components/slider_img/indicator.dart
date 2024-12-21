import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    Key? key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.backgroundColor,
  }) : super(key: key);

  final int count;
  final int currentIndex;
  final Color? activeColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: List.generate(
        count,
        (index) {
          return Container(
              width: 10,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: currentIndex == index ? activeColor : backgroundColor,
            ),
          );
        },
      ),
    );
  }
}
