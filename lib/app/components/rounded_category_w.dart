import 'package:dots/core/utils/assets_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/utils/const_file.dart';

class RoundedCategoryWidget extends StatelessWidget {
  const RoundedCategoryWidget({
    Key? key,
    this.borderColor = Colors.black12,
    required this.onTap,
    this.iconSize = 35,
    this.withAll = false,
    this.borderWidth = 2,
  }) : super(key: key);
  final double iconSize, borderWidth;
  final bool withAll;
  final Color borderColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  width: borderWidth,
                  color: borderColor,
                ),
              ),
              child: ClipOval(
                child: SvgPicture.asset(
                  AssetsFile.svg('svg.svg'),
                  width: iconSize,
                  height: iconSize,
                ),
              ),
            ),
            GP.g1(),
          ],
        ),
      ),
    );
  }
}
