import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:gap/gap.dart';

class ConstString {
  static const String loggedInKey = 'LoggedIn';
  static const String privacyPolicy = 'v_privacy_policy';
  static const String howToUse = 'v_how_to_use';
}

class ConstSizes {
  static double s1 = 1;
  static double s2 = 2;
  static double s3 = 3;
  static double s4 = 4;
  static double s6 = 6;
  static double s8 = 8;
  static double s16 = 16;
  static double s18 = 18;
  static double s24 = 24;
  static double s32 = 32;
  static double s40 = 40;
  static double s60 = 60;
  static double radius4 = 4;
  static double radius8 = 8;
  static double radius16 = 16;
  static double radius24 = 24;
}

class GP extends StatelessWidget {
  const GP._(this.widget, {Key? key}) : super(key: key);
  factory GP.gp(size) => GP._(Gap(size));
  factory GP.sBox({double? width, double? height}) =>
      GP._(SizedBox(height: height, width: height));
  factory GP.g4() => GP._(Gap(ConstSizes.s4));
  factory GP.g2() => GP._(Gap(ConstSizes.s3));
  factory GP.g3() => GP._(Gap(ConstSizes.s2));
  factory GP.g1() => GP._(Gap(ConstSizes.s1));
  factory GP.g8() => GP._(Gap(ConstSizes.s8));
  factory GP.g16() => GP._(Gap(ConstSizes.s16));
  factory GP.g24() => GP._(Gap(ConstSizes.s24));
  factory GP.g32() => GP._(Gap(ConstSizes.s32));
  factory GP.g40() => GP._(Gap(ConstSizes.s40));
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return widget;
  }
}

class Sizer extends StatelessWidget {
  const Sizer._(
      {Key? key,
      required this.width,
      required this.height,
      required this.child})
      : super(key: key);

  factory Sizer.s8({required Widget child}) => Sizer._(
        height: 8,
        width: 8,
        child: child,
      );
  factory Sizer.s16({required Widget child}) => Sizer._(
        height: 16,
        width: 16,
        child: child,
      );
  factory Sizer.s24({required Widget child}) => Sizer._(
        height: 24,
        width: 24,
        child: child,
      );
  factory Sizer.s32({required Widget child}) => Sizer._(
        height: 32,
        width: 32,
        child: child,
      );
  factory Sizer.s40({required Widget child}) => Sizer._(
        height: 40,
        width: 40,
        child: child,
      );
  final Widget child;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height, child: child);
  }
}

class Pd extends StatelessWidget {
  const Pd({Key? key, required this.child, this.horizontal, this.vertical})
      : super(key: key);

  factory Pd.p2({required Widget child}) => Pd.symmetric(
        horizontal: ConstSizes.s2,
        vertical: ConstSizes.s2,
        child: child,
      );

  factory Pd.p4({required Widget child}) => Pd.symmetric(
        horizontal: ConstSizes.s4,
        vertical: ConstSizes.s4,
        child: child,
      );
  factory Pd.p8({required Widget child}) => Pd.symmetric(
        horizontal: ConstSizes.s8,
        vertical: ConstSizes.s8,
        child: child,
      );
  factory Pd.p16({required Widget child}) => Pd.symmetric(
        horizontal: ConstSizes.s16,
        vertical: ConstSizes.s16,
        child: child,
      );
  factory Pd.p24({required Widget child}) => Pd.symmetric(
        horizontal: ConstSizes.s24,
        vertical: ConstSizes.s24,
        child: child,
      );
  factory Pd.p32({required Widget child}) => Pd.symmetric(
        horizontal: ConstSizes.s32,
        vertical: ConstSizes.s32,
        child: child,
      );
  factory Pd.p40({required Widget child}) => Pd.symmetric(
        horizontal: ConstSizes.s40,
        vertical: ConstSizes.s40,
        child: child,
      );
  factory Pd.symmetric({
    required Widget child,
    double? horizontal,
    double? vertical,
  }) =>
      Pd(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontal ?? 0.0,
            vertical: vertical ?? 0.0,
          ),
          child: child,
        ),
      );
  factory Pd.only({
    required Widget child,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) =>
      Pd(
        child: Padding(
            padding: EdgeInsets.only(
              bottom: bottom ?? 0.0,
              top: top ?? 0.0,
              left: left ?? 0.0,
              right: right ?? 0.0,
            ),
            child: child),
      );

  final Widget child;
  final double? horizontal;
  final double? vertical;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
