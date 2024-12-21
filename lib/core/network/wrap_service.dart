import 'package:flutter/cupertino.dart';
import 'package:geeks_service/service/response_status.dart';

class WrapService extends StatelessWidget {
  const WrapService(
      {super.key,
      required this.status,
      required this.child,
      this.initialState,
      this.messageFailure});
  final ResponseStatus status;

  final Widget child;
  final Widget? initialState;
  final String? messageFailure;

  @override
  Widget build(BuildContext context) {
    return status.when(
      noInternetC: () => const Center(child: Text('You Loose Connection')),
      error: (_) => Center(child: Text(messageFailure ?? '')),
      initial: () => initialState ?? const SizedBox(),
      loading: () => const Center(child: CupertinoActivityIndicator()),
      success: () => child,
    );
  }
}
