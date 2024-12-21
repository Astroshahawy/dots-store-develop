// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:geeks_service/geeks_service.dart';

// import '../model/how_to_use_m_res.dart';
// import '../repo/how_to_use_repo.dart';

// part 'how_to_use_state.dart';

// class HowToUseCubit extends Cubit<HowToUseState> {
//   HowToUseCubit(this._repo) : super(const HowToUseState());
//   final HowToUseRepo _repo;

//   Future<void> howToUseCu() async {
//     emit(state.copyWith(status: const ResponseStatus.loading()));

//     final response = await _repo.howToUseRepo();

//     response.fold((failure) {
//       if (failure == Failure.noInternetConnection()) {
//         emit(
//           state.copyWith(
//             status: const ResponseStatus.noInternetC(),
//           ),
//         );
//       } else {
//         emit(
//           state.copyWith(
//             status: const ResponseStatus.error(),
//           ),
//         );
//       }
//     }, (success) {
//       if (success.success!) {
//         emit(
//           state.copyWith(
//             status: const ResponseStatus.success(),
//             data: success.data,
//           ),
//         );
//       } else {
//         emit(
//           state.copyWith(
//             status: const ResponseStatus.error(),
//           ),
//         );
//       }
//     });
//   }
// }
