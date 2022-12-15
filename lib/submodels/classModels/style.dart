import 'package:flutter/material.dart';

class Style {
  OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(9),
    borderSide: BorderSide(
      color: Colors.blue.shade600,
      width: 1,
    ),
  );

  OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(9),
    borderSide: const BorderSide(
      color: Color.fromARGB(255, 165, 165, 165),
      width: 1,
    ),
  );

  OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(9),
    borderSide: const BorderSide(
      color: Colors.red,
      width: 1,
    ),
  );

  Color textFieldIconColor = Colors.blue.shade700;
}
