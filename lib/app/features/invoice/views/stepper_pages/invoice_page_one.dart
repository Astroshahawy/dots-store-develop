import 'package:dots/app/features/invoice/views/table_widgte.dart';
import 'package:dots/core/network/wrap_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../logic/cubit/invoice_cubit.dart';

class UnPaidPageOne extends HookWidget {
  final double? height;
  // final List<String>? slider;

  const UnPaidPageOne({
    this.height,
    // this.slider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, state) {
        final unPadData = state.data?.data?.invoices ?? [];
        return WrapService(
            status: state.status,
            child: unPadData.isEmpty
                ? Center(child: Text('empty_invoice_str'.tr()))
                : TableWidget(
                    invoice: unPadData,
                    total: state.data?.data?.total ?? 0,
                  ));
      },
    );
  }
}
