import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wander_nest/core/themes/app_custom_colors.dart';

import 'app_color_scheme.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: AppColorSchemes.light,
    extensions: <ThemeExtension<dynamic>>[
      const AppCustomColors(
        water: Colors.blue,
        fire: Colors.deepOrange,
        hostLanguage: Colors.indigo,
        disabled: Colors.grey,
      ),
    ],
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
    extensions: <ThemeExtension<dynamic>>[
      AppCustomColors(
        water: Colors.blue.shade300,
        fire: Colors.deepOrange.shade300,
        hostLanguage: Colors.indigo.shade300,
        disabled: Colors.grey.shade600,
      ),
    ],
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
