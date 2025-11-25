// lib/ui/browsing/browsing_textstyles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrowsingTextStyles {
  static final profileName = GoogleFonts.montserrat(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );
  static final h1 = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );
  static final body = GoogleFonts.montserrat(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    color: Colors.grey,
    letterSpacing: 0,
  );
  static final intro = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    letterSpacing: 0,
  );
}
