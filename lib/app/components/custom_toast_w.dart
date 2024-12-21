import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';

void toast(String message, {bool success = false}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    // timeInSecForIosWeb: 1,
    backgroundColor: success ? Colors.red : Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Future<void> showToast(String message, {bool success = false}) async {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    // timeInSecForIosWeb: 1,
    backgroundColor: success ? Colors.green : Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
