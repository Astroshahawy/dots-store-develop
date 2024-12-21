import 'package:geeks_service/service/exception_dio_message.dart';
import 'package:geeks_service/service/logger.dart';
import 'package:geeks_service/service/response_status.dart';

void fail(Failure failure, void Function(dynamic) emitterState, dynamic state) {
  'error'.logV('errror');
  if (failure == Failure.noInternetConnection()) {
    emitterState(state.copyWith(status: const ResponseStatus.noInternetC()));
  } else {
    emitterState(
      state.copyWith(
        status: const ResponseStatus.error(),
        message: failure.message,
      ),
    );
  }
}
