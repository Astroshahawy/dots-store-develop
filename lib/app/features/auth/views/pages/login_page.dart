import 'package:dots/app/features/PinCode/views/pages/pin_code_screen.dart';
import 'package:dots/app/features/auth/SignUp/signup_screen.dart';
import 'package:dots/app/shared/GlobalVariable/global_variable.dart';
import 'package:dots/core/route/route_name.dart';
import 'package:dots/core/route/routes.dart';
import 'package:dots/core/utils/local_storage/local_storage.dart';
import 'package:dots/core/utils/local_storage/storage_keys.dart';
import 'package:easy_localization/easy_localization.dart' as loc;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:geeks_service/service/response_status.dart';
import 'package:geeks_widget/custom_widgets/custom_widgets.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/const_file.dart';
import '../../../../components/custom_toast_w.dart';
import '../../../../components/forms/custom_text_field.dart';
import '../../../../components/loading_widget.dart';
import '../../../../components/no_network_dialog.dart';
import '../../../../components/valid_error_text_input.dart';
import '../../logic/blocs/login_bloc/login_bloc.dart';
import '../widgets/account_type_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          const SizedBox(height: 50),
          Column(
            children: [
              Text(
                loc.tr('select_account_type_str'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              const AccountTypeSection(),
            ],
          ),
          const SizedBox(height: 50),
          Text(
            loc.tr('sign_in_account_str'),
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          const PhoneRegister(),
          const SizedBox(height: 25),
          const PasswordLogin(),
          const SizedBox(height: 35),
          BlocConsumer<LoginBloc, LoginState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == const ResponseStatus.success()) {
                token = state.data!.loginDataModel!.token.toString();
                Storage.putString(StorageAuthKeys.token,
                    state.data!.loginDataModel!.token.toString());

                // context.pushAndRemoveStack(PinCodeScreen(
                //   state.phone.value,
                // ));
                context.pushName(RouteName.homePage);
              } else if (state.status == const ResponseStatus.noInternetC()) {
                serverErrorDialog(context);
              } else if (state.status == const ResponseStatus.error()) {
                toast('${state.message}', success: false);
               
                if (state.message == 'user need to verfiy phone first') {
 context.pushAndRemoveStack(PinCodeScreen(
                  state.phone.value,
                ));
                }
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: !state.formzStatus.isValid
                    ? null
                    : () {
                        context.read<LoginBloc>().add(FormSubmittedLogin());
                      },
                child: state.status == const ResponseStatus.loading()
                    ? const SizedBox(
                        height: 25,
                        width: 25,
                        child: LoadingWidget(),
                      )
                    : Text(loc.tr('login_str')),
              );
            },
          ),
          GP.sBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(SignUpScreeen());
            },
            child: Text(loc.tr('signup_str')),
          )
        ],
      ),
    );
  }
}

class AccountTypeSection extends StatelessWidget {
  const AccountTypeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginType = context.watch<LoginBloc>().state.loginType;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AccountTypeWidget(
          accountType: LoginType.manager,
          color: loginType == LoginType.manager
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer.withOpacity(.5),
          onTap: () {
            // loginType = AccountType.manager;
            Storage.putInt(StorageAuthKeys.userTypeINT, 2);
            context
                .read<LoginBloc>()
                .add(const ChangeLoginTypeEvent(type: LoginType.manager));
          },
          txtColor: loginType == LoginType.manager
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer
                  .withOpacity(.2),
        ),
        AccountTypeWidget(
          accountType: LoginType.employee,
          color: loginType == LoginType.employee
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer.withOpacity(.5),
          onTap: () {
            // loginType = AccountType.employee;
            Storage.putInt(StorageAuthKeys.userTypeINT, 1);

            context
                .read<LoginBloc>()
                .add(const ChangeLoginTypeEvent(type: LoginType.employee));
          },
          txtColor: loginType == LoginType.employee
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer
                  .withOpacity(.2),
        ),
      ],
    );
  }
}

///* Phone Register Input ...................
class PhoneRegister extends StatelessWidget {
  const PhoneRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, Phone>(
      selector: (state) {
        return state.phone;
      },
      builder: (context, state) {
        return Column(
          children: [
            CustomTextField(
              initialValue: state.value,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              onChanged: (value) => context
                  .read<LoginBloc>()
                  .add(PhoneChangedLogin(phone: value!)),
              icon: Icon(
                FontAwesomeIcons.mobileScreenButton,
                size: ConstSizes.s18,
              ),
              label: loc.tr('phone_num_str'),
            ),
            GP.g8(),
            validErrorText(
              state,
              loc.tr('phone_validation_str'),
            ),
          ],
        );
      },
    );
  }
}

//* Password Login Input ...................

class PasswordLogin extends StatelessWidget {
  const PasswordLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, String>(
      selector: (state) {
        return state.password;
      },
      builder: (context, state) {
        return Column(
          children: [
            CustomTextField(
              initialValue: state,
              onChanged: (value) => context
                  .read<LoginBloc>()
                  .add(PasswordChangedLogin(password: value!)),
              icon: Icon(FontAwesomeIcons.lock, size: ConstSizes.s18),
              suffixIcon: Icon(FontAwesomeIcons.eye, size: ConstSizes.s18),
              label: loc.tr('password_str'),
            ),
            GP.g8(),
            // validErrorText(
            //   state,
            //   'pass_validation_str'loc.tr(),
            // ),
          ],
        );
      },
    );
  }
}
