import 'package:dots/core/utils/assets_file.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
    this.height = 150,
    this.width = 150,
  }) : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsFile.images('logo_dots.png'),
      height: height,
      width: width,
    );
  }
}
