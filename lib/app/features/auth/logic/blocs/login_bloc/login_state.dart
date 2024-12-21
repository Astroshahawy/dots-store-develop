part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.formzStatus = FormzStatus.pure,
    this.status = const ResponseStatus.initial(),
    this.message,
    this.data,
    this.logout,
    this.phone = const Phone.pure(),
    this.password = '',
    this.loginType = LoginType.employee,
  });

  final FormzStatus formzStatus;
  final ResponseStatus status;
  final String? message;
  final bool? logout;
  final Phone phone;
  final String password;
  final LoginType loginType;
  final LoginModel? data;

  LoginState copyWith({
    ResponseStatus? status,
    FormzStatus? formzStatus,
    String? message,
    bool? logout,
    Phone? phone,
    String? password,
    LoginModel? data,
    LoginType? loginType,
  }) {
    return LoginState(
      status: status ?? this.status,
      formzStatus: formzStatus ?? this.formzStatus,
      message: message ?? this.message,
      data: data ?? this.data,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      logout: logout ?? this.logout,
      loginType: loginType ?? this.loginType,
    );
  }

  @override
  List<Object?> get props => [
        formzStatus,
        message,
        data,
        phone,
        password,
        status,
        logout,
        loginType,
      ];
}

enum LoginType {
  manager,
  employee,
}
