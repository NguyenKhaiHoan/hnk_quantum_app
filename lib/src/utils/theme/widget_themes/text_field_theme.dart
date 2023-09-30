import 'package:flutter/material.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';

class CustomTextFormFieldTheme {
  CustomTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      prefixIconColor: darkColor,
      floatingLabelStyle: const TextStyle(color: darkColor),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 2, color: darkColor),
      ));

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    prefixIconColor: Color.fromRGBO(251, 109, 169, 1),
    floatingLabelStyle:
        const TextStyle(color: Color.fromRGBO(251, 109, 169, 1)),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromRGBO(251, 109, 169, 1),
        width: 3,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
