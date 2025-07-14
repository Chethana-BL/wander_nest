import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/features/maps/domain/utils/grid_key_calculator.dart';

void main() {
  group('GridKeyCalculator', () {
    test('returns consistent grid key for same coordinates', () {
      final key1 = GridKeyCalculator.getKey(
        lat: 12.3456,
        lng: 78.9012,
        gridSize: 0.1,
      );
      final key2 = GridKeyCalculator.getKey(
        lat: 12.3499,
        lng: 78.9044,
        gridSize: 0.1,
      );

      expect(key1, equals(key2));
    });

    test('returns different keys for different grids', () {
      final key1 = GridKeyCalculator.getKey(
        lat: 12.0,
        lng: 78.0,
        gridSize: 0.1,
      );
      final key2 = GridKeyCalculator.getKey(
        lat: 13.0,
        lng: 78.0,
        gridSize: 0.1,
      );

      expect(key1, isNot(equals(key2)));
    });

    test('grid key format is "latIndex,longIndex"', () {
      final key = GridKeyCalculator.getKey(lat: 10.0, lng: 20.0, gridSize: 0.5);

      // Ensure grid key format is valid: "<int>,<int>" (e.g., "5,12", "-3,-7")
      // Matches optional negative integers separated by a comma.
      expect(key, matches(RegExp(r'^-?\d+,-?\d+$')));
    });
  });
}
