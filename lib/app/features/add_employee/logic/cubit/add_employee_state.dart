part of 'add_employee_cubit.dart';

class EmployeeState extends Equatable {
  const EmployeeState({
    this.data,
    this.message,
    this.phonePoints,
    this.name,
    this.mobile,
    this.password,
    this.employeesList = const [],
    this.status = const ResponseStatus.initial(),
    this.addStatus = const ResponseStatus.initial(),
  });

  final MessageModel? data;
  final String? message;
  final ResponseStatus status;
  final ResponseStatus addStatus;
  final String? phonePoints;
  final String? name;
  final String? mobile;
  final String? password;
  final List<EmployeeDataM> employeesList;

  EmployeeState copyWith({
    MessageModel? data,
    String? message,
    ResponseStatus? status,
    ResponseStatus? addStatus,
    String? phonePoints,
    String? name,
    String? mobile,
    String? password,
    List<EmployeeDataM>? employeesList,
  }) {
    return EmployeeState(
      phonePoints: phonePoints ?? this.phonePoints,
      name: name ?? this.name,
      password: password ?? this.password,
      mobile: mobile ?? this.mobile,
      data: data ?? this.data,
      message: message ?? this.message,
      status: status ?? this.status,
      addStatus: addStatus ?? this.addStatus,
      employeesList: employeesList ?? this.employeesList,
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
        data,
        phonePoints,
        name,
        mobile,
        password,
        employeesList,
        addStatus,
      ];
}
