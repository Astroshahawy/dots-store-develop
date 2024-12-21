import 'package:flutter/material.dart';

class ErrorScaffold extends StatelessWidget {
  const ErrorScaffold({
    required this.body,
    Key? key,
  }) : super(key: key);

  final Widget body;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Page Not Found')),
        body: body,
      );
}

// class ErrorView extends StatelessWidget {
//   const ErrorView(this.error, {Key? key}) : super(key: key);
//   final Exception error;

//   @override
//   Widget build(BuildContext context) => Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SelectableText(error.toString()),
//             TextButton(
//               onPressed: () => context.go('/'),
//               child: const Text('Home'),
//             ),
//           ],
//         ),
//       );
// }
