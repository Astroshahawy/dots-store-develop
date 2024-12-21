import 'package:dots/core/route/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:geeks_service/geeks_service.dart';
import 'package:geeks_service/service/logger.dart';

import '../../pay_c.dart';
import '../logic/model/offer_model.dart';

enum HeaderRow {
  indexNumber('م'),
  indexOperation('رقم\nالعملية'),
  numberPoint('عدد\nالنقاط الممنوحة'),
  userNumber('رقم\nاشتراك العميل'),
  amountInvoices('مبلغ\nفاتورة العميل'),
  timeOperation('وقت\nتنفيذ العملية'),
  pointAmount('قيمة\nالنقطة'),
  paidBy('طريقة \nالدفع');

  final String data;
  const HeaderRow(this.data);
}

class TableWidget extends StatelessWidget {
  const TableWidget({
    super.key,
    required this.invoice,
    required this.total,
  });
  final List<Invoices> invoice;
  final num total;

  @override
  Widget build(BuildContext context) {
    const secureStorage = FlutterSecureStorage();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('${'total_str'.tr()} $total ${'sr_str'.tr()}'),
              MaterialButton(
                onPressed: () async {
                  await secureStorage.read(key: 'vendorId').then((value) {
                    logger.i(value);
                    context.push(PayC(
                      url:
                          'https://dotsapp.co/pay_vendor_invoice?vendor_id=$value&brand=VISA',
                    ));
                  });
                },

                // context
                //     .read<CashbackOfferCubit>()
                //     .confirmCashbackOffer(
                //         cashbackOfferItem.id!);

                color: context.schemeGx.primary,
                child: const Text('الدفع الإلكتروني')
                    .textColorGx(context.schemeGx.onPrimary),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: DataTable(
                columnSpacing: 7,
                horizontalMargin: 3,
                showBottomBorder: true,
                dividerThickness: 2,
                sortColumnIndex: 0,
                /*  dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.08);
                  }
                  return Colors.lightGreen; // Use the default value.
                }), */
                headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.08);
                  }
                  return Colors.blue; // Use the default value.
                }),
                border:
                    const TableBorder(bottom: BorderSide(color: Colors.black)),
                columns: [
                  ...List.generate(
                      HeaderRow.values.length,
                      (index) => DataColumn(
                            label: Center(
                                child: Text(HeaderRow.values[index].data)
                                    .fontSizeGx(8)
                                    .textAlignGx(TextAlign.center)
                                    .textColorGx(Colors.white)),
                          ),
                      growable: false)
                ],
                rows: [
                  ...List.generate(
                      invoice.length,
                      (index) => DataRow(cells: [
                            DataCell(TextDataCell(
                              label: index.toString(),
                            )),
                            DataCell(TextDataCell(
                              label: invoice[index].operationNumber.toString(),
                            )),
                            DataCell(TextDataCell(
                              label: invoice[index].pointsNumber.toString(),
                            )),
                            DataCell(TextDataCell(
                              label: invoice[index].userPhone.toString(),
                            )),
                            DataCell(TextDataCell(
                              label: invoice[index].invoiceAmount.toString(),
                            )),
                            DataCell(TextDataCell(
                              label: invoice[index].date.toString(),
                            )),
                            DataCell(TextDataCell(
                              label: invoice[index].pointValue.toString(),
                            )),
                            DataCell(TextDataCell(
                              label: invoice[index].paidBy.toString(),
                            )),
                          ]))
                ]),
          ),
        ),
      ],
    );
  }
}

class TextDataCell extends StatelessWidget {
  const TextDataCell({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(label).fontSizeGx(10).textAlignGx(TextAlign.center));
  }
}
