import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppStyle {
  //static Color bgColor = const Color(0xFFe2e2ff);
  static Color mainColor = Colors.black12;
  static Color accentColor = const Color(0xFF0065FF);

  static List<Color> cardsColor = [
    Colors.white,
    Colors.red.shade200,
    Colors.pink.shade200,
    Colors.orange.shade200,
    Colors.yellow.shade200,
    Colors.green.shade200,
    Colors.blue.shade200,
    Colors.blueGrey.shade200,
  ];

  static TextStyle mainTitle = GoogleFonts.roboto(
    fontSize: 18.0, fontWeight: FontWeight.w700
  );
  static TextStyle mainContent = GoogleFonts.nunito(
      fontSize: 16.0, fontWeight: FontWeight.normal
  );
  static TextStyle dateTitle = GoogleFonts.roboto(
      fontSize: 13.0, fontWeight: FontWeight.w500
  );
}