import 'package:flutter/material.dart';

class WrongWidget extends StatelessWidget {
  const WrongWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Something went wrong!'),
    );
  }
}
