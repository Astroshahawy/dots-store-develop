import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geeks_service/geeks_service.dart';

import '../model/static_pages_m_res.dart';
import '../repo/static_pages_repo.dart';



part 'static_pages_state.dart';

class StaticPagesCubit extends Cubit<StaticPagesState> {
  StaticPagesCubit(this._repo) : super(const StaticPagesState());
  final StaticPagesRepo _repo;

  Future<void> staticPagesCu(String pageType,) async {
    emit(state.copyWith(status: const ResponseStatus.loading()));

    final response = await _repo.staticPagesRepo(pageType);

    response.fold((failure) {
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
          ),
        );
      }
    }, (success) {
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
          ),
        );
      }
    });
  }
}
