import 'dart:ui';

extension ColorOpacityHelpers on Color {
  /// Returns a new color with the specified opacity.
  /// Sets the alpha channel as a fraction (0.0 to 1.0).
  /// Safer alternative to deprecated `.withOpacity()`.
  Color alphaF(double fraction) {
    assert(
      fraction >= 0.0 && fraction <= 1.0,
      'alphaF() expects a value between 0.0 and 1.0. Received: $fraction',
    );
    return withAlpha((fraction * 255).round());
  }
}
