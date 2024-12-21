import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geeks_service/service/response_status.dart';

import '../../../../../core/network/fails_method.dart';
import '../model/slider_model.dart';
import '../repo/slider_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repo) : super(const HomeState());
  final SliderHomeRepo repo;

  void fetchSlider() async {
    emit(state.copyWith(status: const ResponseStatus.loading()));
    final product = await repo.get();
    product.fold(
      (failure) => fail(failure, (data) => emit(data), const HomeState()),
      (success) {
        success.fold(
            (_) => emit(state.copyWith(
                  status: const ResponseStatus.success(),
                  data: null,
                )), (success) {
          if (success.success!) {
            emit(
              state.copyWith(
                status: const ResponseStatus.success(),
                data: success.data,
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: const ResponseStatus.error(),
                data: null,
              ),
            );
          }
        });
      },
    );
  }
}
