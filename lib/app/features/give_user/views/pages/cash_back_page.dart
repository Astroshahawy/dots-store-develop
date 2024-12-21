import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dots/app/features/offer_packages/views/pages/offer_packages_page.dart';
import 'package:dots/core/utils/const_file.dart';
import 'package:dots/l10n/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geeks_service/service/response_status.dart';
import 'package:get/get.dart' as getx;

import '../../../../../core/utils/assets_file.dart';
import '../../../../components/loading_widget.dart';
import '../../../../components/no_network_dialog.dart';
import '../../../home/logic/cubit/home_cubit.dart';
import '../../logic/cubit/contact_list_controller.dart';
import '../../logic/cubit/give_user_cubit.dart';

class CashbackPage extends HookWidget {
  const CashbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneError = useValueNotifier<bool?>(null);
    final amountError = useValueNotifier<bool?>(null);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.giveCashback).tr(),
      ),
      body: BlocListener<GiveUserCubit, GiveUserState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == const ResponseStatus.success()) {
            context.read<HomeCubit>().fetchSlider();
            // toast('${state.message}', success: true);
            AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              btnOkOnPress: () {},
              title: 'تم بنجاح',
              headerAnimationLoop: false,
              desc:
                  'تم منح كاش باك ${formKey.currentState?.value['amount']} \n لرقم ${formKey.currentState?.value['phone']} ',
            ).show();
            // Navigator.pop(context);
          } else if (state.status == const ResponseStatus.noInternetC()) {
            serverErrorDialog(context);
          } else if (state.status == const ResponseStatus.error()) {
            // toast('${state.message}', success: false);
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'فشل',
              desc: state.message,
              headerAnimationLoop: false,
              btnCancelOnPress: () {},
            ).show();
          }
        },
        child: getx.GetBuilder<ContactListController>(
          init: ContactListController(),
          builder: (controller) {
            return FormBuilder(
              key: formKey,
              onChanged: () {
                formKey.currentState!.save();
                debugPrint(formKey.currentState!.value.toString());
              },
              autovalidateMode: AutovalidateMode.disabled,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  GP.g16(),
                  // const LogoWidget(),
                  Image.asset(
                    AssetsFile.images('cashback.png'),
                    height: 180,
                  ),
                  GP.g16(),
                  FormBuilderTextField(
                    name: 'phone',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.mobileScreenButton,
                        size: ConstSizes.s18,
                      ),
                      hintText: localization.tr("phone_num_str"),
                      hintStyle: context.labelSmallGx,
                      suffixIcon: phoneError.value == null
                          ? const SizedBox()
                          : phoneError.value!
                              ? Icon(Icons.error, color: context.schemeGx.error)
                              : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      phoneError.value =
                          !(formKey.currentState?.fields['phone']?.validate() ??
                              false);
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'هذا الحقل مطلوب',
                      ),
                      FormBuilderValidators.match(
                        RegExp('^05.*'),
                        errorText: 'يجب ان يبدأ رقم الهاتف ب 05',
                      ),
                      FormBuilderValidators.maxLength(
                        10,
                        errorText: 'يجب الا يزيد عن 10 ارقام',
                      ),
                    ]),
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  GP.g16(),
                  FormBuilderTextField(
                    name: 'amount',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        FontAwesomeIcons.coins,
                        size: ConstSizes.s18,
                      ),
                      hintText: "مبلغ فاتوره العميل",
                      hintStyle: context.labelSmallGx,
                      suffixIcon: amountError.value == null
                          ? const SizedBox()
                          : amountError.value!
                              ? Icon(Icons.error, color: context.schemeGx.error)
                              : const Icon(Icons.check, color: Colors.green),
                    ),
                    onChanged: (val) {
                      amountError.value = !(formKey
                              .currentState?.fields['amount']
                              ?.validate() ??
                          false);
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'هذا الحقل مطلوب',
                      ),
                    ]),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                  GP.g24(),
                  BlocBuilder<GiveUserCubit, GiveUserState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formKey.currentState?.saveAndValidate() ??
                              false) {
                            context.read<GiveUserCubit>().giveBalance(
                                  phone: formKey.currentState?.value['phone'],
                                  amount: formKey.currentState?.value['amount'],
                                );
                          }
                        },
                        child: state.status == const ResponseStatus.loading()
                            ? const SizedBox(
                                height: 25,
                                width: 25,
                                child: LoadingWidget(),
                              )
                            : const Text('منح الكاش باك'),
                      );
                    },
                  ),
                  GP.g16(),
                  controller.isLoading
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: LoadingWidget(),
                        )
                      : SizedBox(
                          width: 200,
                          height: 150,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OfferPackagesPage()));
                            },
                            child: Container(
                              width: 200,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage(controller
                                          .contactListModel!.data.vendorImage),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
