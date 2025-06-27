import 'package:flutter/material.dart';

/// [AppCustomColors] Enables centralized customization of colors across the app.
/// for water, fire, host language, and disabled states.

@immutable
class AppCustomColors extends ThemeExtension<AppCustomColors> {
  const AppCustomColors({
    required this.water,
    required this.fire,
    required this.hostLanguage,
    required this.disabled,
  });
  final Color water;
  final Color fire;
  final Color hostLanguage;
  final Color disabled;

  @override
  AppCustomColors copyWith({
    Color? water,
    Color? fire,
    Color? hostLanguage,
    Color? disabled,
  }) {
    return AppCustomColors(
      water: water ?? this.water,
      fire: fire ?? this.fire,
      hostLanguage: hostLanguage ?? this.hostLanguage,
      disabled: disabled ?? this.disabled,
    );
  }

  @override
  AppCustomColors lerp(ThemeExtension<AppCustomColors>? other, double t) {
    if (other is! AppCustomColors) return this;
    return AppCustomColors(
      water: Color.lerp(water, other.water, t)!,
      fire: Color.lerp(fire, other.fire, t)!,
      hostLanguage: Color.lerp(hostLanguage, other.hostLanguage, t)!,
      disabled: Color.lerp(disabled, other.disabled, t)!,
    );
  }
}
