import 'package:dots/app/features/Wallet/Logic/wallet_controller.dart';
import 'package:dots/app/features/Wallet/View/Widgets/payment_enum.dart';
import 'package:dots/app/features/Wallet/View/Widgets/paymeny_method_model.dart';
import 'package:dots/app/features/Wallet/View/Widgets/selected_payment_method.dart';
import 'package:dots/app/features/Wallet/View/payment_web_view.dart';
import 'package:dots/core/utils/const_file.dart';
import 'package:easy_localization/easy_localization.dart' as loc;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:dots/app/features/Wallet/View/Widgets/payment_method_tap.dart';
import 'package:geeks_service/geeks_service.dart';
import 'package:get/get.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    // context.read<WalletCubit>().fetchWallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.tr('wallet')),
      ),
      body: const _WalletBody(),
    );
  }
}

class _WalletBody extends HookWidget {
  const _WalletBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentMethods = useState<String?>(null);
    // final amountError = useValueNotifier<bool?>(null);
    String amo = '';
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: formKey,
          onChanged: () {
            formKey.currentState!.save();
            debugPrint(formKey.currentState!.value.toString());
          },
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: GetBuilder<WalletController>(
              init: WalletController(),
              builder: (_) {
                return _.isLoading
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          // BlocBuilder<WalletCubit, WalletState>(
                          //   builder: (context, state) {
                          //     return
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'رصيدك الحالي',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    ' ${_.profileModel!.data.wallet} ${loc.tr('sar')}',
                                    style: TextStyle(
                                      color: context.schemeGx.primary,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]),
                          //   },
                          // ),
                          GP.g24(),
                          GP.g24(),
                          Text(
                            loc.tr('charge_wallet_str'),
                            style: Theme.of(context).textTheme.titleMedium,
                          ).boldGx(),

                          GP.g16(),
                          Text(
                            loc.tr('enterChargeAmount'),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          GP.g16(),
                          // _AmountField(amountError: amountError, formKey: formKey),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonFormField<int>(
                              borderRadius: BorderRadius.circular(20),
                              onSaved: (newValue) {
                                amo = newValue.toString();
                              },
                              menuMaxHeight: 200,
                              // key: formKey,
                              hint: const Text('المبلغ')
                                  .textStyleGx(context.labelSmallGx),
                              onChanged: (value) {
                                _.changeChargedValue(value!);
                                amo = value.toString();
                                debugPrint(amo.toString());
                                // typeOfServices.value = value;
                                // debugPrint(value);
                              },
                              items: [
                                DropdownMenuItem(
                                  value: 50,

                                  child: Text(
                                    '50',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  // onTap: () {},
                                ),
                                DropdownMenuItem(
                                  value: 100,
                                  child: Text(
                                    '100',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 200,
                                  child: Text(
                                    '200',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 300,
                                  child: Text(
                                    '300',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 400,
                                  child: Text(
                                    '400',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 500,
                                  child: Text(
                                    '500',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GP.g24(),
                          GP.g24(),
                          Text(loc.tr('choose_payment_method_str')).boldGx(),
                          GP.g24(),

                          SelectPaymentMethod(
                            paymentMethodsList: const [
                              PaymentMethods(
                                  name: 'VISA',
                                  image: 'assets/images/Visa.svg'),
                              PaymentMethods(
                                  name: 'MADA',
                                  image: 'assets/images/Mada.svg'),
                            ],
                            onSelect: (selected) =>
                                paymentMethods.value = selected,
                          ),
                          GP.g40(),
                          GP.g24(),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: ()async {
                              String vendorID ='';
                                await  secureStorage.read(key: 'vendorId').then((value) => vendorID = value!);
                              printInfo(info: _.chargedValue.toString());
                              printInfo(info: paymentMethods.value.toString());
                              Get.to(PaymentWebviewPage(
                                  paymentUrl:
                                      'https://dotsapp.co/charge_vendor_amount?vendor_id=$vendorID&brand=${paymentMethods.value}&amount=${_.chargedValue}'));
                            },
                            child: Text(loc.tr('chargeWallet')),
                          ),
                          // const _PaymentMethodsSection()
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _AmountField extends StatelessWidget {
  const _AmountField({
    Key? key,
    required this.amountError,
    required this.formKey,
  }) : super(key: key);

  final ValueNotifier<bool?> amountError;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'amount',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: loc.tr("amount"),
        suffixIcon: amountError.value == null
            ? const SizedBox()
            : amountError.value!
                ? Icon(Icons.error, color: context.schemeGx.error)
                : const Icon(Icons.check, color: Colors.green),
      ),
      onChanged: (val) {
        amountError.value =
            !(formKey.currentState?.fields['amount']?.validate() ?? false);
      },
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText: loc.tr('required_field_str'),
        ),
      ]),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
    );
  }
}

class _PaymentMethodsSection extends HookWidget {
  const _PaymentMethodsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentMethodS = useState<int?>(null);
    return Column(
      children: [
        PaymentMethodsTap(
          title: 'apple pay',
          value: PymentMethods.applePay.index,
          selectedValue: paymentMethodS,
          paymentImg:
              'https://icons.veryicon.com/png/o/business/third-party-sharing-payment/apple-pay.png',
          onChanged: (int? value) {
            if (value != null) {
              paymentMethodS.value = value;
            }
          },
        ),
        PaymentMethodsTap(
          title: 'سداد',
          value: PymentMethods.sadad.index,
          selectedValue: paymentMethodS,
          paymentImg:
              'https://www.bankaljazira.com/Portals/0/Images/SADAD_OnLine_Payment_SMART_Page_Banner_1200x409px_EN-4.jpg',
          onChanged: (int? value) {
            if (value != null) {
              paymentMethodS.value = value;
            }
          },
        ),
        PaymentMethodsTap(
          title: 'مدى',
          value: PymentMethods.mada.index,
          selectedValue: paymentMethodS,
          paymentImg:
              'https://raw.githubusercontent.com/github/explore/5540c4de7efb0398f9c706ca0c608c8d3a587df2/topics/mada/mada.png',
          onChanged: (int? value) {
            if (value != null) {
              paymentMethodS.value = value;
            }
          },
        ),
      ],
    );
  }
}
