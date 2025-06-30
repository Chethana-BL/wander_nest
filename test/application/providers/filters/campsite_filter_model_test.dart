import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/application/providers/filters/campsite_filter_model.dart';

void main() {
  group('CampsiteFilter', () {
    group('Empty filter', () {
      test('has all fields null and isEmpty is true', () {
        const filter = CampsiteFilter.empty;
        expect(filter.isCloseToWater, isNull);
        expect(filter.isCampFireAllowed, isNull);
        expect(filter.hostLanguages, isNull);
        expect(filter.priceRange, isNull);
        expect(filter.isEmpty, isTrue);
        expect(filter.hasAnyFilter, isFalse);
        expect(filter.activeFilterCount, 0);
      });
    });

    group('Active filter count', () {
      test('filter with all fields set has correct activeFilterCount', () {
        final filter = const CampsiteFilter(
          isCloseToWater: true,
          isCampFireAllowed: false,
          hostLanguages: ['EN', 'FR'],
          priceRange: RangeValues(10, 50),
        );
        expect(filter.activeFilterCount, 4);
        expect(filter.isEmpty, isFalse);
        expect(filter.hasAnyFilter, isTrue);
      });

      test('filter with only one field set', () {
        final filter = const CampsiteFilter(isCloseToWater: true);
        expect(filter.activeFilterCount, 1);
        expect(filter.isEmpty, isFalse);
        expect(filter.hasAnyFilter, isTrue);
      });

      test('hostLanguages empty list is not counted as active filter', () {
        final filter = const CampsiteFilter(hostLanguages: []);
        expect(filter.activeFilterCount, 0);
        expect(filter.isEmpty, isTrue);
        expect(filter.hasAnyFilter, isFalse);
      });

      test('hostLanguages null and empty are treated the same', () {
        final filterNull = const CampsiteFilter(hostLanguages: null);
        final filterEmpty = const CampsiteFilter(hostLanguages: []);
        expect(filterNull.activeFilterCount, 0);
        expect(filterEmpty.activeFilterCount, 0);
      });
    });

    group('copyWith', () {
      test('updates fields and resets correctly', () {
        final filter = const CampsiteFilter(
          isCloseToWater: true,
          isCampFireAllowed: false,
          hostLanguages: ['EN'],
          priceRange: RangeValues(10, 20),
        );

        final updated = filter.copyWith(
          isCloseToWater: false,
          hostLanguages: ['DE', 'FR'],
          priceRange: const RangeValues(30, 40),
        );
        expect(updated.isCloseToWater, false);
        expect(updated.isCampFireAllowed, false);
        expect(updated.hostLanguages, ['DE', 'FR']);
        expect(updated.priceRange, const RangeValues(30, 40));

        final reset = filter.copyWith(
          resetCloseToWater: true,
          resetCampFireAllowed: true,
          resetHostLanguages: true,
          resetPriceRange: true,
        );
        expect(reset.isCloseToWater, isNull);
        expect(reset.isCampFireAllowed, isNull);
        expect(reset.hostLanguages, isNull);
        expect(reset.priceRange, isNull);
        expect(reset.isEmpty, isTrue);
      });

      test('can set fields to null using reset flags', () {
        final filter = const CampsiteFilter(isCampFireAllowed: true);
        final updated = filter.copyWith(resetCampFireAllowed: true);
        expect(updated.isCampFireAllowed, isNull);
      });

      test('does not reset fields unless reset flag is true', () {
        final filter = const CampsiteFilter(isCloseToWater: true);
        final updated = filter.copyWith();
        expect(updated.isCloseToWater, true);
      });

      test('will update only the field that is within "copyWith"', () {
        final filter = const CampsiteFilter(
          isCloseToWater: true,
          isCampFireAllowed: false,
        );
        final updated = filter.copyWith(isCampFireAllowed: true);
        expect(updated.isCloseToWater, true);
        expect(updated.isCampFireAllowed, true);
      });
    });
  });
}
