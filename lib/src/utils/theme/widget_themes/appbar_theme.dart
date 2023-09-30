import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: darkColor, size: 18.0),
    actionsIconTheme: IconThemeData(color: darkColor, size: 18.0),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: whiteColor, size: 18.0),
    actionsIconTheme: IconThemeData(color: whiteColor, size: 18.0),
  );
}
