import 'package:bloc/bloc.dart';
import 'package:dots/app/features/auth/logic/repo/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../../core/utils/local_storage/storage_service.dart';

part 'logout_state.dart';

final StorageService _storage = StorageService();

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._repo) : super(const LogoutState());

  final AuthRepo _repo;
  final authBox = _storage.getAuthBox();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Future<void> logoutCu() async {
    emit(
      state.copyWith(
        status: const ResponseStatus.loading(),
      ),
    );

    final response = await _repo.logoutRepo();

    response.fold((failure) {
      authBox.put(StorageH.authKey, false);
      secureStorage.deleteAll();

      if (failure == Failure.noInternetConnection()) {
        emit(
          state.copyWith(
            status: const ResponseStatus.noInternetC(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: const ResponseStatus.error(),
            message: failure.message,
          ),
        );
      }
    }, (success) {
      authBox.put(StorageH.authKey, false);
      secureStorage.deleteAll();

      if (success.success!) {
        // authBox.put(StorageH.authKey, false);
        // secureStorage.deleteAll();
        emit(
          state.copyWith(
            status: const ResponseStatus.success(),
            message: success.message,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: const ResponseStatus.error(),
            message: success.message,
          ),
        );
      }
    });
  }
}
