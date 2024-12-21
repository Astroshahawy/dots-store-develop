import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geeks_service/service/response_status.dart';

import '../../../../../core/network/fails_method.dart';
import '../model/offer_model.dart';
import '../repo/invoices.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit(this._invoicesRepo) : super(const InvoiceState());
  final InvoicesRepo _invoicesRepo;

  void getInvoicesUnpaid() async {
    emit(state.copyWith(status: const ResponseStatus.loading()));

    final product = await _invoicesRepo.getUnpaidInvoices();
    product.fold(
      (failure) => fail(failure, (data) => emit(data), const InvoiceState()),
      (success) => emit(
        state.copyWith(status: const ResponseStatus.success(), data: success),
      ),
    );
  }

  void getInvoicesPaid() async {
    emit(state.copyWith(status: const ResponseStatus.loading()));
    final product = await _invoicesRepo.getPaidInvoices();
    product.fold(
      (failure) => fail(failure, (data) => emit(data), const InvoiceState()),
      (success) => emit(
        state.copyWith(status: const ResponseStatus.success(), data: success),
      ),
    );
  }
}
