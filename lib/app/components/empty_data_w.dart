import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/utils/assets_file.dart';

class EmptyW extends StatelessWidget {
  const EmptyW({Key? key, this.text}) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            AssetsFile.emptyDataLottie,
            height: 200,
            width: 200,
            repeat: false,
          ),
          Text(text ?? 'Data Not Found'),
        ],
      ),
    );
  }
}
