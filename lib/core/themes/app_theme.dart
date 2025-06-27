import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color_scheme.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorSchemes.light,
    scaffoldBackgroundColor: AppColorSchemes.light.surface,
    textTheme: GoogleFonts.latoTextTheme().apply(
      bodyColor: AppColorSchemes.light.onSurface,
      displayColor: AppColorSchemes.light.onSurface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorSchemes.light.primary,
      foregroundColor: AppColorSchemes.light.onPrimary,
    ),
    iconTheme: IconThemeData(color: AppColorSchemes.light.primary),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorSchemes.dark,
    scaffoldBackgroundColor: AppColorSchemes.dark.surface,
    textTheme: GoogleFonts.latoTextTheme().apply(
      bodyColor: AppColorSchemes.dark.onSurface,
      displayColor: AppColorSchemes.dark.onSurface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorSchemes.dark.primary,
      foregroundColor: AppColorSchemes.dark.onPrimary,
    ),
    iconTheme: IconThemeData(color: AppColorSchemes.dark.primary),
  );
}
