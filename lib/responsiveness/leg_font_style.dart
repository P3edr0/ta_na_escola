import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'responsive.dart';

//////////////////////// PRIMARY FONT STYLE ////////////////////////

abstract class TneFontStyle {
  static TextStyle h3 = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(22),
    color: Colors.black,
  );
  static TextStyle h4 = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(20),
    color: Colors.black,
  );

  static TextStyle title = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(18),
    color: Colors.black,
  );
  static TextStyle bodyLarge = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(16),
    color: Colors.black,
  );
  static TextStyle body = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(14),
    color: Colors.black,
  );
  static TextStyle small = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(12),
    color: Colors.black,
  );
  static TextStyle verySmall = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(10),
    color: Colors.black,
  );

  //+++++++++++++++++++  BOLD FONTS +++++++++++++++++++++++++++++++++++++++

  static TextStyle h3Bold = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(22),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h4Bold = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(20),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleBold = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(18),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyLargeBold = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(16),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyBold = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(14),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle smallBold = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(12),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle verySmallBold = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(10),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  //////////////////////// SECONDARY FONT STYLE ////////////////////////

  static TextStyle h3Sec = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(22),
    color: Colors.black,
  );
  static TextStyle h4Sec = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(20),
    color: Colors.black,
  );

  static TextStyle titleSec = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(18),
    color: Colors.black,
  );
  static TextStyle bodyLargeSec = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(16),
    color: Colors.black,
  );
  static TextStyle bodySec = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(14),
    color: Colors.black,
  );
  static TextStyle smallSec = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(12),
    color: Colors.black,
  );
  static TextStyle verySmallSec = GoogleFonts.roboto().copyWith(
    fontSize: Responsive.getFontValue(10),
    color: Colors.black,
  );

  //+++++++++++++++++++  BOLD FONTS +++++++++++++++++++++++++++++++++++++++

  static TextStyle h3BoldSec = GoogleFonts.sora().copyWith(
    fontSize: Responsive.getFontValue(22),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h4BoldSec = GoogleFonts.sora().copyWith(
    fontSize: Responsive.getFontValue(20),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleBoldSec = GoogleFonts.sora().copyWith(
    fontSize: Responsive.getFontValue(18),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyLargeBoldSec = GoogleFonts.sora().copyWith(
    fontSize: Responsive.getFontValue(16),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bodyBoldSec = GoogleFonts.sora().copyWith(
    fontSize: Responsive.getFontValue(14),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle smallBoldSec = GoogleFonts.sora().copyWith(
    fontSize: Responsive.getFontValue(12),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle verySmallBoldSec = GoogleFonts.sora().copyWith(
    fontSize: Responsive.getFontValue(10),
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}
