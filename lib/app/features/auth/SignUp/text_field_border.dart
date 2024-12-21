import 'package:flutter/material.dart';

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.deepPurple),
      borderRadius: BorderRadius.circular(10),
      gapPadding: 10);
}

InputDecoration inputDecoration() {
  return InputDecoration(
    disabledBorder: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    enabledBorder: outlineInputBorder(),
    border: outlineInputBorder(),
  );
}

Widget buildReactionPreview({
  required String title,
  required String imageUrl,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        CircleAvatar(
          radius: 16,
          backgroundImage: AssetImage(
            imageUrl,
          ),
        ),
        // Image(
        //   image: AssetImage(
        //     imageUrl,
        //   ),
        //   height: 35,
        //   width: 50,
        // ),
      ],
    ),
  );
}
