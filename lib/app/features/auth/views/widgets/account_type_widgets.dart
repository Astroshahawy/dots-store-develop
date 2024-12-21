import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../logic/blocs/login_bloc/login_bloc.dart';


class AccountTypeWidget extends StatelessWidget {
  const AccountTypeWidget({
    Key? key,
    required this.accountType,
    required this.color,
    required this.onTap,
    required this.txtColor,
  }) : super(key: key);

  final LoginType accountType;
  final Color color;
  final Color txtColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: color,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          accountType == LoginType.employee ? "empolyee_str".tr() : "manager_str".tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: txtColor,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
