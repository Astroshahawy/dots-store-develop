import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geeks_service/geeks_service.dart';
import 'package:geeks_service/service/logger.dart';

import '../../../../../../core/utils/local_storage/storage_service.dart';


part 'redirect_state.dart';

final StorageService _storage = StorageService();

class RedirectCubit extends Cubit<RedirectState> {
  RedirectCubit() : super(const RedirectState());

  final _authBox = _storage.getAuthBox();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<bool> get unAuthS async {
    final authS = _authBox.get(StorageH.authKey);
    final token = await _secureStorage.read(key: 'token');
    logger.d(authS, 'from cubit');
    logger.d(token, 'from cubit');

    return authS == null || authS == false || token == null || token.isEmpty;
  }

  // void redirectNotifier() async {
  //   final unAuth = await unAuthS;
  //   logger.d(unAuth, 'un Auth from cubit');

  //   //unAuth(authS: authS, token: token);
  //   if (unAuth) {
  //     emit(state.copyWith(authStatus: false));
  //   } else {
  //     emit(state.copyWith(authStatus: true));
  //   }
  //   logger.d(state.authStatus);
  // }
}
