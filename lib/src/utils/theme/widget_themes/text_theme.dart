import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/colors.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: darkColor),
    displayMedium: GoogleFonts.poppins(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: darkColor),
    displaySmall: GoogleFonts.poppins(
        fontSize: 24.0, fontWeight: FontWeight.normal, color: darkColor),
    headlineMedium: GoogleFonts.poppins(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: darkColor),
    headlineSmall: GoogleFonts.poppins(
        fontSize: 18.0, fontWeight: FontWeight.normal, color: darkColor),
    titleLarge: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: darkColor),
    bodyLarge: GoogleFonts.poppins(fontSize: 14.0, color: darkColor),
    bodyMedium:
        GoogleFonts.poppins(fontSize: 14.0, color: darkColor.withOpacity(0.8)),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: whiteColor),
    displayMedium: GoogleFonts.poppins(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: whiteColor),
    displaySmall: GoogleFonts.poppins(
        fontSize: 24.0, fontWeight: FontWeight.normal, color: whiteColor),
    headlineMedium: GoogleFonts.poppins(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: whiteColor),
    headlineSmall: GoogleFonts.poppins(
        fontSize: 18.0, fontWeight: FontWeight.normal, color: whiteColor),
    titleLarge: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: whiteColor),
    bodyLarge: GoogleFonts.poppins(fontSize: 14.0, color: whiteColor),
    bodyMedium:
        GoogleFonts.poppins(fontSize: 14.0, color: whiteColor.withOpacity(0.8)),
  );
}
