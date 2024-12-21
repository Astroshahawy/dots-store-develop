import 'package:bloc/bloc.dart';
import 'package:dots/app/features/give_user/logic/model/message_model_model.dart';
import 'package:dots/app/features/give_user/logic/repo/give_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../../core/network/fails_method.dart';

part 'give_user_state.dart';

class GiveUserCubit extends Cubit<GiveUserState> {
  GiveUserCubit(this.repo) : super(const GiveUserState());
  final GiveUserRepo repo;

  void givePoints({
    required String phone,
    required String amount,
  }) async {
    emit(state.copyWith(status: const ResponseStatus.loading()));
    final product = await repo.givePoints(
      phone: phone,
      amount: amount,
    );
    product.fold(
      (failure) => fail(failure, (data) => emit(data), const GiveUserState()),
      (success) {
        if (success.success!) {
          emit(state.copyWith(
              status: const ResponseStatus.success(),
              data: success,
              message: success.message));
        } else {
          emit(state.copyWith(
            status: const ResponseStatus.error(),
            message: success.message,
          ));
        }
      },
    );
  }

  void giveBalance({
    required String phone,
    required String amount,
  }) async {
    emit(state.copyWith(status: const ResponseStatus.loading()));

    final product = await repo.giveBalance(
      phone: phone,
      amount: amount,
    );
    product.fold(
      (failure) => fail(failure, (data) => emit(data), const GiveUserState()),
      (success) {
        if (success.success!) {
          emit(state.copyWith(
              status: const ResponseStatus.success(),
              data: success,
              message: success.message));
        } else {
          emit(state.copyWith(
            status: const ResponseStatus.error(),
            message: success.message,
          ));
        }
      },
    );
  }
}
