import 'package:dots/core/utils/const_file.dart';
import 'package:dots/injection/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geeks_service/service/response_status.dart';

import '../../../../../core/utils/assets_file.dart';
import '../../../../components/custom_toast_w.dart';
import '../../../../components/forms/custom_text_field.dart';
import '../../../../components/loading_widget.dart';
import '../../../../components/no_network_dialog.dart';
import '../../logic/cubit/give_meal_cubit.dart';

class GiveMealPage extends StatelessWidget {
  const GiveMealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GiveMealCubit>(
      create: (context) => injector<GiveMealCubit>(),
      child: const GiveMealBody(),
    );
  }
}

class GiveMealBody extends StatelessWidget {
  const GiveMealBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('giveMeal'.tr()),
      ),
      body: BlocListener<GiveMealCubit, GiveMealState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == const ResponseStatus.success()) {
            toast('${state.message}', success: true);
          } else if (state.status == const ResponseStatus.noInternetC()) {
            serverErrorDialog(context);
          } else if (state.status == const ResponseStatus.error()) {
            toast('${state.message}', success: false);
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GP.g16(),
            Image.asset(
              AssetsFile.images('ttttttt.jpg'),
              height: 160,
            ),
            GP.g16(),
            CustomTextField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              label: 'phone_num_str'.tr(),
              icon: Icon(
                FontAwesomeIcons.mobileScreenButton,
                size: ConstSizes.s18,
              ),
              onChanged: (value) {
                if (value!.length == 10) {
                  context.read<GiveMealCubit>().changePhonePoint(value);
                }
              },
            ),
            GP.g24(),
            BlocBuilder<GiveMealCubit, GiveMealState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state.phonePoints != null
                      ? () {
                          context.read<GiveMealCubit>().giveMeal();
                          // Navigator.pop(context);
                        }
                      : () {},
                  child: state.status == const ResponseStatus.loading()
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: LoadingWidget(),
                        )
                      : const Text('منح الخدمه'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
