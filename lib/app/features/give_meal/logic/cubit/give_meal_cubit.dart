import 'package:bloc/bloc.dart';
import 'package:dots/app/features/give_user/logic/model/message_model_model.dart';
import 'package:equatable/equatable.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../../core/network/fails_method.dart';
import '../repo/give_meal_repo.dart';

part 'give_meal_state.dart';

class GiveMealCubit extends Cubit<GiveMealState> {
  GiveMealCubit(this.repo) : super(const GiveMealState());
  final GiveMealRepo repo;

  changePhonePoint(String phone) => emit(state.copyWith(phonePoints: phone));

  void giveMeal() async {
    emit(state.copyWith(status: const ResponseStatus.loading()));
    final product = await repo.giveMeal(
      phone: state.phonePoints!,
    );
    product.fold(
      (failure) => fail(failure, (data) => emit(data), const GiveMealState()),
      (success) => emit(state.copyWith(
        status: const ResponseStatus.success(),
        message: success.message,
      )),
    );
  }
}
