import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget({
    Key? key,
    required this.lottie,
    this.height,
    /* this.width, */
  }) : super(key: key);
  final String lottie;
  final double? height;
  // final double? width;
  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      lottie,
      height: height ?? 150,
      // width: width ?? 120,
      repeat: false,
      fit: BoxFit.contain,
    );
  }
}
