import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/shared/extensions/color_extensions.dart';

void main() {
  group('ColorOpacityHelpers - alphaF()', () {
    const baseColor = Color(0xFF336699);

    test('returns correct color with 0% opacity', () {
      final result = baseColor.alphaF(0.0);
      expect(result.a, 0);
      expect(result.r, baseColor.r);
      expect(result.g, baseColor.g);
      expect(result.b, baseColor.b);
    });

    test('returns correct color with 50% opacity', () {
      final result = baseColor.alphaF(0.5);
      expect(result.a, closeTo(0.5, 1));
    });

    test('returns correct color with 100% opacity', () {
      final result = baseColor.alphaF(1.0);
      expect(result.a, 1);
    });

    test('throws assertion error when value < 0.0', () {
      expect(() => baseColor.alphaF(-0.1), throwsA(isA<AssertionError>()));
    });

    test('throws assertion error when value > 1.0', () {
      expect(() => baseColor.alphaF(1.1), throwsA(isA<AssertionError>()));
    });
  });
}
