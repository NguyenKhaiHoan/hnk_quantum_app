import 'package:flutter/material.dart';
import 'package:quantum_app_summer_2023/src/utils/theme/widget_themes/appbar_theme.dart';
import 'package:quantum_app_summer_2023/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:quantum_app_summer_2023/src/utils/theme/widget_themes/text_field_theme.dart';
import 'package:quantum_app_summer_2023/src/utils/theme/widget_themes/text_theme.dart';

class CustomAppTheme {
  CustomAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: CustomTextTheme.lightTextTheme,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: CustomTextTheme.darkTextTheme,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFormFieldTheme.darkInputDecorationTheme,
  );
}
