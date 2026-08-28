import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TracelogTextstyles {
  static TextStyle primaryFonts = GoogleFonts.arimo();
  static TextStyle secondaryFonts = GoogleFonts.inconsolata();

  static TextStyle headlineMedium = primaryFonts.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static TextStyle titleMedium = primaryFonts.copyWith(
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  static TextStyle bodyLarge = primaryFonts.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w700,
  );

  static TextStyle bodyMedium = primaryFonts.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  static TextStyle labelLarge = primaryFonts.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w700,
  );

  static TextStyle labelMedium = primaryFonts.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );

  static TextStyle labelSmall = primaryFonts.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodySmall = secondaryFonts.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );
}
