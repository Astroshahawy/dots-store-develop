import 'package:bloc/bloc.dart';
import 'package:dots/app/features/give_user/logic/model/message_model_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../../core/network/fails_method.dart';
import '../model/employee_model.dart';
import '../repo/add_employee_repo.dart';

part 'add_employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit(this.repo) : super(const EmployeeState());
  final EmployeeRepo repo;

  changeMobile(String mobile) => emit(state.copyWith(mobile: mobile));
  changePassword(String password) => emit(state.copyWith(password: password));
  changeName(String name) => emit(state.copyWith(name: name));

  void fetchEmployees() async {
    emit(state.copyWith(status: const ResponseStatus.loading()));
    final product = await repo.getRepo();
    product.fold(
      (failure) => fail(failure, (data) => emit(data), const EmployeeState()),
      (success) {
        emit(
          state.copyWith(
            status: const ResponseStatus.success(),
            employeesList: success.data,
            message: success.message,
          ),
        );
      },
    );
  }

  void deleteEmployee(int id) async {
    emit(state.copyWith(status: const ResponseStatus.loading()));
    final product = await repo.deleteRepo(id);
    product.fold(
        (failure) => fail(failure, (data) => emit(data), const EmployeeState()),
        (success) {
      emit(
        state.copyWith(
          status: const ResponseStatus.loading(),
          data: success,
          message: success.message,
        ),
      );
      fetchEmployees();
    });
  }

  void addEmployee(BuildContext context) async {
    emit(state.copyWith(addStatus: const ResponseStatus.loading()));
    final product = await repo.repo(
      mobile: state.mobile!,
      name: state.name!,
      password: state.password!,
    );
    product.fold(
        (failure) => fail(failure, (data) => emit(data), const EmployeeState()),
        (success) {
      emit(
        state.copyWith(
          addStatus: const ResponseStatus.success(),
          data: success,
          message: success.message,
        ),
      );
      Navigator.pop(context);
      fetchEmployees();
    });
  }
}
