import 'package:dots/app/components/round_card_widget.dart';
import 'package:dots/core/route/route_name.dart';
import 'package:dots/core/route/routes.dart';
import 'package:dots/core/utils/const_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';

import '../../../../../core/network/wrap_service.dart';
import '../../logic/cubit/add_employee_cubit.dart';

class EmployeesPage extends StatelessWidget {
  const EmployeesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('empolyees_str'.tr()),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocBuilder<EmployeeCubit, EmployeeState>(
            builder: (context, state) {
              return WrapService(
                status: state.status,
                child: state.employeesList.isEmpty
                    ? Center(
                        child: Text('no_empolyees_str'.tr()),
                      )
                    : RefreshIndicator(
                        onRefresh: () async =>
                            context.read<EmployeeCubit>().fetchEmployees(),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 16),
                          itemCount: state.employeesList.length,
                          itemBuilder: (context, index) => RoundCardWidget(
                            borderColor: context.schemeGx.onPrimaryContainer
                                .withOpacity(.13),
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${state.employeesList[index].name}')
                                        .boldGx()
                                        .fontSizeGx(16),
                                    GP.g2(),
                                    Text(
                                        '${state.employeesList[index].mobile}'),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    showAlertDialog(context, () {
                                      context
                                          .read<EmployeeCubit>()
                                          .deleteEmployee(
                                              state.employeesList[index].id!);
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: context.schemeGx.error,
                                        size: 20,
                                      ),
                                      Text("delete_str".tr())
                                          .textColorGx(context.schemeGx.error)
                                          .fontSizeGx(12),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              );
            },
          ),
          Pd.p16(
            child: ElevatedButton(
              onPressed: () {
                context.pushName(RouteName.addEmployee);
              },
              child: Text('add_employee_str'.tr()),
            ),
          ),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context, void Function() onTapYes) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("cancel_str".tr()),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    onPressed: onTapYes,
    child: Text("delete_str".tr()).textColorGx(context.schemeGx.error),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("delete_empolyee_str".tr()),
    content: Text("delete_empolyee_confirm_str".tr()),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
