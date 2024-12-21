import 'package:dots/core/utils/const_file.dart';
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
import '../../logic/cubit/add_employee_cubit.dart';

class AddEmployeePage extends StatelessWidget {
  const AddEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('add_employee_str'.tr()),
      ),
      body: Pd.p16(
        child: ListView(
          children: [
            Image.asset(
              AssetsFile.images('add_emplyee.png'),
              height: 170,
            ),
            // GP.g16(),
            CustomTextField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              label: 'empolyee_name_str'.tr(),
              icon: Icon(
                Icons.person,
                size: ConstSizes.s18,
              ),
              onChanged: (String? name) =>
                  context.read<EmployeeCubit>().changeName(name!),
            ),
            GP.g16(),
            CustomTextField(
              onChanged: (String? val) =>
                  context.read<EmployeeCubit>().changeMobile(val!),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              label: 'phone_num_str'.tr(),
              icon: Icon(
                FontAwesomeIcons.mobileScreenButton,
                size: ConstSizes.s18,
              ),
            ),
            GP.g16(),
            CustomTextField(
              onChanged: (String? val) =>
                  context.read<EmployeeCubit>().changePassword(val!),
              icon: Icon(FontAwesomeIcons.lock, size: ConstSizes.s18),
              suffixIcon: Icon(FontAwesomeIcons.eye, size: ConstSizes.s18),
              label: 'password_str'.tr(),
            ),
            GP.g24(),
            BlocConsumer<EmployeeCubit, EmployeeState>(
              listenWhen: (previous, current) =>
                  previous.addStatus != current.addStatus,
              listener: (context, state) {
                if (state.addStatus == const ResponseStatus.success()) {
                  toast('${state.message}', success: true);
                } else if (state.addStatus ==
                    const ResponseStatus.noInternetC()) {
                  serverErrorDialog(context);
                } else if (state.addStatus == const ResponseStatus.error()) {
                  toast('${state.message}', success: false);
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state.mobile != null &&
                          state.password != null &&
                          state.name != null
                      ? () {
                          context.read<EmployeeCubit>().addEmployee(context);
                        }
                      : null,
                  child: state.addStatus == const ResponseStatus.loading()
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: LoadingWidget(),
                        )
                      : Text('add_str'.tr()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}











// Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//       ListTile(
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(color: Colors.black26, width: 1),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         title: const Text('محمد مجدى'),

//         trailing: const Icon(Icons.edit),
//         leading: Padding(
//           padding: const EdgeInsets.all(2.0),
//           child: CircleAvatar(
//             radius: 40,
//             backgroundColor: context.schemeGx.primary,
//             child: CircleAvatar(
//               radius: 35,
//               backgroundColor: Colors.blueGrey[200],
//               backgroundImage: const NetworkImage(
//                   'https://cdn4.iconfinder.com/data/icons/professions-avatars-1/135/88-512.png'),
//             ),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
