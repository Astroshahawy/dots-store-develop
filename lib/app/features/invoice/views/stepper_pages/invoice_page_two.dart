import 'package:dots/core/network/wrap_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../logic/cubit/invoice_cubit.dart';
import '../../logic/model/offer_model.dart';
import '../table_widgte.dart';

class PaidPageTwo extends HookWidget {
  const PaidPageTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, state) {
        final List<Invoices> padInvoice = state.data?.data?.invoices ?? [];
        return WrapService(
          status: state.status,
          child: padInvoice.isEmpty
              ? const Center(child: Text('لايوجد فواتير غير مدفوعة'))
              : TableWidget(
                  invoice: padInvoice,
                  total: state.data?.data?.total ?? 0,
                ),
        );
      },
    );
  }
}
