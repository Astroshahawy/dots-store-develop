import 'package:flutter/material.dart';

class BodyPageWidget extends StatelessWidget {
  const BodyPageWidget({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) => children[index]);
  }
}
