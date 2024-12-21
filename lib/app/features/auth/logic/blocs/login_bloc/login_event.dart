part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ChangeLoginTypeEvent extends LoginEvent {
  const ChangeLoginTypeEvent({required this.type});
  final LoginType type;

  @override
  List<Object> get props => [type];
}
class PhoneChangedLogin extends LoginEvent {
  const PhoneChangedLogin({required this.phone});
  final String phone;

  @override
  List<Object> get props => [phone];
}

class PasswordChangedLogin extends LoginEvent {
  const PasswordChangedLogin({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class FormSubmittedLogin extends LoginEvent {}

class LogoutEvent extends LoginEvent {}
