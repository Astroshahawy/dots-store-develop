import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      this.outBorder = false,
      this.outBorderColor,
      this.elevation,
      this.child,
      this.bgColor,
      this.margin,
      this.borderRadius = BorderRadius.zero});
  final bool outBorder;
  final Color? outBorderColor;
  final BorderRadiusGeometry borderRadius;
  final double? elevation;
  final Color? bgColor;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    // final Color color = ElevationOverlay.colorWithOverlay(
    //     context.schemeGx.surface, context.schemeGx.primary, 3.0);
    return Card(
      color: bgColor,
      shadowColor: Theme.of(context).colorScheme.shadow,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      margin: margin,
      shape: RoundedRectangleBorder(
          side: outBorder
              ? BorderSide(
                  color:
                      outBorderColor ?? Theme.of(context).colorScheme.outline,
                )
              : BorderSide.none,
          borderRadius: borderRadius),
      elevation: elevation,
      child: child,
    );
  }
}
