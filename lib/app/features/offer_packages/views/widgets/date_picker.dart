import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geeks_service/service/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

Future<String> showDatePickerFun(BuildContext ctx) async {
  var datePicked = DateFormat(
    'yyyy-MM-dd',
    'en',
  ).format(DateTime.now());

  await showCupertinoModalPopup<String>(
    context: ctx,
    builder: (BuildContext builder) {
      return SizedBox(
        height: MediaQuery.of(ctx).copyWith().size.height * 0.31,
        child: Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: CupertinoDatePicker(
              // backgroundColor: ColorFile.selectColor.withOpacity(0.1),
              use24hFormat: true,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                logger.d('selected time is $value');
                datePicked = DateFormat(
                  'yyyy-MM-dd',
                  'en',
                ).format(value);
              },
              // initialDateTime: DateTime.now(),
              maximumDate: DateTime.now().add(const Duration(days: 30)),
              minimumDate: DateTime.now(),
            )),
      );
    },
  );
  return datePicked;
}
