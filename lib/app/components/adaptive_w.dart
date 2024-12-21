import 'package:flutter/material.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';


class AdaptiveWidget extends StatelessWidget {
  const AdaptiveWidget({super.key, required this.mobileWidget, required this.otherWidget});
  final Widget mobileWidget;
  final Widget otherWidget;
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.isMobile) {
          return mobileWidget;
        } else {
          return otherWidget;
        }
      },
    );
  }
}
