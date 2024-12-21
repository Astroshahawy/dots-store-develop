import 'package:flutter/material.dart';

class RoundCardWidget extends StatelessWidget {
  const RoundCardWidget({
    super.key,
    this.color,
    this.onTap,
    this.width,
    this.margin,
    this.radius,
    this.height,
    this.padding,
    this.alignment,
    this.colorShadow,
    this.shadowOffset,
    this.borderColor = Colors.transparent,
    required this.child,
  });

  final Color? color;
  final Color borderColor;
  final Widget child;
  final double? width;
  final double? radius;
  final double? height;
  final Color? colorShadow;
  final Offset? shadowOffset;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      
      child: Container(
        padding: padding,
        alignment: alignment,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 10),
          color: color ?? Theme.of(context).colorScheme.background,
          border: Border.all(
            color: borderColor,
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              offset: shadowOffset ?? const Offset(0, 3.5),
              blurRadius: 8,
              spreadRadius: 1,
              color: colorShadow ?? Colors.grey.withOpacity(.2),
            ),
          ],
        ),
        margin: margin,
        child: child,
      ),
    );
  }
}
