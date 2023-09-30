import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class CustomOutlinedButtonTheme {
  CustomOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      fixedSize: const Size(395, 60),
      foregroundColor: darkColor,
      side: const BorderSide(color: darkColor),
      padding: const EdgeInsets.symmetric(vertical: tDefaultSize),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      fixedSize: const Size(395, 60),
      foregroundColor: whiteColor,
      side: const BorderSide(color: whiteColor),
      padding: const EdgeInsets.symmetric(vertical: tDefaultSize),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
    ),
  );
}
