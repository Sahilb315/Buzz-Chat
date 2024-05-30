import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle heading = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w800,
    ),
  );

  static TextStyle subHeading = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );

  static TextStyle normalText = GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  );
}
