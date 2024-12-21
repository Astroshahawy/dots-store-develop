import 'package:flutter/material.dart';
import 'package:flutter_extension_pk/flutter_extension_pk.dart';

Widget validErrorText(var state, String message) {
  if (state.value.isEmpty) {
    return const SizedBox();
  }
  if (!state.valid) {
    return Text(
      message,
    ).textColorGx(Colors.red).fontSizeGx(13);
  }
  return const SizedBox();
}
