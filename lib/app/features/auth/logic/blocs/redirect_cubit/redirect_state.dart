part of 'redirect_cubit.dart';

class RedirectState extends Equatable {
  const RedirectState({
    this.authStatus = false,
  });
  final bool authStatus;

  RedirectState copyWith({
    bool? authStatus,
  }) {
    return RedirectState(
      authStatus: authStatus ?? this.authStatus,
    );
  }

  @override
  List<Object> get props => [authStatus];
}
