
import 'package:flutter/material.dart';

Widget buildEventDetailText(String title, String text, Color textColor) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
    ],
  );
}