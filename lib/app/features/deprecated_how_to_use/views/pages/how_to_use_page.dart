// import 'package:dots/app/features/how_to_use/logic/how_to_use_cubit/how_to_use_cubit.dart';
// import 'package:dots/injection/injection_container.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/network/wrap_service.dart';
// import '../widgets/how_to_use_widgets.dart';

// class HowToUsePage extends StatelessWidget {
//   const HowToUsePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<HowToUseCubit>(
//       create: (_) => injector<HowToUseCubit>()..howToUseCu(),
//       child: const HowToUseBody(),
//     );
//   }
// }

// class HowToUseBody extends StatelessWidget {
//   const HowToUseBody({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'how_to_use_str'.tr(),
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//       ),
//       body: BlocBuilder<HowToUseCubit, HowToUseState>(
//         builder: (context, state) {
//           return WrapService(
//             status: state.status,
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: state.data.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ExpandableWidget(
//                   title: '${state.data[index].title}',
//                   description: '${state.data[index].description}',
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
