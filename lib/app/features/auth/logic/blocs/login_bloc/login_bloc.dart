import 'package:bloc/bloc.dart';
import 'package:dots/injection/injection_container.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:geeks_service/geeks_service.dart';
import 'package:geeks_service/service/logger.dart';
import 'package:geeks_widget/custom_widgets/form/form.dart';

import '../../../../../../core/utils/local_storage/data/store_user_info.dart';
import '../../../../../../core/utils/local_storage/storage_service.dart';
import '../../model/login_model.dart';
import '../../repo/auth_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

final StorageService _storage = StorageService();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo repo;
  final authBox = _storage.getAuthBox();

  LoginBloc(this.repo) : super(const LoginState()) {
    on<PhoneChangedLogin>(_onPhoneChanged);
    on<PasswordChangedLogin>(_onPasswordChanged);
    on<FormSubmittedLogin>(_onFormSubmitted);
    on<ChangeLoginTypeEvent>(_changeLoginType);
    // on<LogoutEvent>(_logout);
  }

  void _changeLoginType(ChangeLoginTypeEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(loginType: event.type));
  }

  void _onPhoneChanged(PhoneChangedLogin event, Emitter<LoginState> emit) {
    Phone.reg = r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$';
    final phone = Phone.dirty(event.phone);
    emit(
      state.copyWith(
        phone: phone.valid ? phone : Phone.pure(event.phone),
        formzStatus: Formz.validate([phone]),
      ),
    );
  }

  void _onPasswordChanged(
      PasswordChangedLogin event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        password: event.password,
        formzStatus: FormzStatus.valid,
      ),
    );
  }

  // ( Login ) ...............
  Future<void> _onFormSubmitted(
    FormSubmittedLogin event,
    Emitter<LoginState> emit,
  ) async {
    logger.d(state.phone, 'Phone');
    logger.d(state.password, 'Password');

    final phone = Phone.dirty(state.phone.value);

    emit(state.copyWith(
      phone: phone,
      password: state.password,
      formzStatus: Formz.validate([phone]),
    ));
    if (state.formzStatus.isValidated) {
      emit(state.copyWith(status: const ResponseStatus.loading()));

      final response = await repo.login(
        loginType: state.loginType,
        phone: state.phone.value,
        password: state.password,
      );

      response.fold((failure) {
        if (failure == Failure.noInternetConnection()) {
          emit(state.copyWith(status: const ResponseStatus.noInternetC()));
        } else {
          emit(
            state.copyWith(
              status: const ResponseStatus.error(),
              message: failure.message,
            ),
          );
        }
      }, (success) {
        if (success.success!) {
          authBox.put(StorageH.authKey, true);

          emit(
            state.copyWith(
              status: const ResponseStatus.success(),
              data: success,
            ),
          );
          UserInfoStorage.saveLocalUserInfo(
              success, injector<FlutterSecureStorage>());
        } else {
          emit(
            state.copyWith(
              status: const ResponseStatus.error(),
              message: success.message,
            ),
          );
        }
      });
      emit(state.copyWith(status: const ResponseStatus.initial()));
    }
  }

  // ( Logout ) ...............
  // void _logout(LogoutEvent event, Emitter<LoginState> emit) async {
  //   final response = await repo.logout();

  //   response.fold((failure) {
  //     if (failure == Failure.noInternetConnection()) {
  //       emit(state.copyWith(status: const ResponseStatus.noInternetC()));
  //     } else {
  //       emit(
  //         state.copyWith(
  //           status: const ResponseStatus.error(),
  //           message: failure.message,
  //         ),
  //       );
  //     }
  //   }, (success) {
  //     emit(
  //       state.copyWith(
  //         status: const ResponseStatus.success(),
  //         logout: success,
  //       ),
  //     );
  //   });
  // }
}
