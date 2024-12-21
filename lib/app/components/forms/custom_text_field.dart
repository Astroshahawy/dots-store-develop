import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.controller,
    this.onChanged,
    this.validator,
    required this.label,
    this.icon,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.errorText,
    this.onTap,
    this.maxLines,
    this.initialValue,
    this.readOnly = false,
  }) : super(key: key);
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Icon? icon, suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? label;
  final String? initialValue;
  final String? errorText;
  final bool readOnly;
  final int? maxLines;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    // final ColorTheme myColors = Theme.of(context).extension<ColorTheme>()!;
    return
        //  PhysicalModel(
        //   color: myColors.whiteColor,
        //   elevation: 6,
        //   shadowColor: myColors.txtDark.withOpacity(.3),
        //   borderRadius: BorderRadius.circular(ConstSizes.s40),
        //   child:
        TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.name,
      textInputAction: textInputAction ?? TextInputAction.next,
      validator: validator,
      decoration: InputDecoration(
        errorText: errorText,
        hintText: label,
        hintStyle: const TextStyle(color: Colors.black),
        prefixIcon: icon,
        suffixIcon: suffixIcon,
      ),
      // ),
    );
  }
}

class MultiLineTextField extends StatelessWidget {
  const MultiLineTextField({
    Key? key,
    this.controller,
    this.onChanged,
    this.validator,
    required this.label,
    this.icon,
    this.suffixIcon,
    this.textInputAction,
    this.keyboardType,
    this.errorText,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);
  final TextEditingController? controller;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Icon? icon, suffixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? errorText;
  final String? label;
  final bool readOnly;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    // final myColors = Theme.of(context).colorScheme;

    return
        //  PhysicalModel(
        //   color: myColors.,
        //   elevation: 6,
        //   shadowColor: myColors.txtDark.withOpacity(.3),
        //   borderRadius: BorderRadius.circular(ConstSizes.s40),
        //   child:
        TextFormField(
      minLines: 2,
      maxLines: 5,
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        errorText: errorText,
        hintText: label,
        hintStyle: const TextStyle(color: Colors.black),
        prefixIcon: icon,
        suffixIcon: suffixIcon,
      ),
      // ),
    );
  }
}
