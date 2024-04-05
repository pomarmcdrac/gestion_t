import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  Color principal   = const Color.fromRGBO(74, 105, 159, 1);
  Color secundario  = const Color.fromRGBO(155, 195, 235, 1);
  Color textos      = const Color.fromRGBO(1, 4, 53, 1);
  Color fondo       = const Color.fromRGBO(196, 230, 250, 1);
  Color claro       = const Color.fromRGBO(254, 254, 254, 1);

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: principal,

    // Text
    textTheme: TextTheme(
      titleLarge: GoogleFonts.montserratAlternates(),
      titleMedium: GoogleFonts.montserratAlternates(fontSize: 35),
    ),

    // Appbar
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: secundario,
      shadowColor: textos,
      toolbarHeight: 350,
      titleTextStyle: TextStyle(
        color: claro,
        fontSize: 26,
        fontFamily: GoogleFonts.montserratAlternates().fontFamily,
        fontWeight: FontWeight.bold,
      ),
      elevation: 10,
    ),
  );
}