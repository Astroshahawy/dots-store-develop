import 'package:dots/core/utils/const_file.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_extension_pk/extensions/extensions.dart';

import '../../../../core/network/wrap_service.dart';
import '../../../../injection/injection_container.dart';
import '../../../components/empty_data_w.dart';
import '../logic/model/notification_model.dart';
import '../logic/notifications_cubit/notifications_cubit.dart';
import '../logic/repo/notifications_repo.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationsCubit(injector<NotificationsRepo>())..fetch(),
      child: const _Notifications(),
    );
  }
}

class _Notifications extends StatelessWidget {
  const _Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notificationString'.tr()),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<NotificationsCubit>().fetch();
        },
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            return WrapService(
              status: state.status,
              child: state.data.isEmpty
                  ? const EmptyW(text: 'لا يوجد اشعارات حاليا')
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationCardWidget(data: state.data[index]);
                      },
                    ),
            );
          },
        ),
      ),
    );
  }
}

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final NotificationM data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ConstSizes.s16),
      decoration: BoxDecoration(
        // color: context.schemeEx.onPrimary,
        border: Border.all(color: context.schemeGx.background),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ConstSizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    color: const Color(0xffBAD1C7),
                    child: const Icon(
                      Icons.notification_important_sharp,
                      size: 22,
                    ),
                  ),
                ),
                GP.g8(),
                Text(data.title).boldGx().textColorGx(context.schemeGx.primary),
              ],
            ),
            GP.g8(),
            Text(
              data.message,
            ).fontSizeGx(13),
            GP.g8(),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
