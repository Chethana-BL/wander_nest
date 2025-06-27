import 'package:flutter/material.dart';

/// A class that defines the color schemes for the Wander Nest app.
/// It provides both light and dark themes based on a seed color.
class AppColorSchemes {
  static const seedColor = Color.fromARGB(255, 64, 135, 124);

  static final light = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
  );

  static final dark = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
  );
}
