import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../core/network/fails_method.dart';
import '../model/notification_model.dart';
import '../repo/notifications_repo.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this.repo) : super(const NotificationsState());
  final NotificationsRepo repo;

  void fetch() async {
    emit(state.copyWith(status: const ResponseStatus.loading()));

    final response = await repo.getRepo();
    response.fold(
      (failure) =>
          fail(failure, (data) => emit(data), const NotificationsState()),
      (success) => emit(state.copyWith(
          status: const ResponseStatus.success(), data: success.data)),
    );
  }
}
