import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_enums.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_state.dart';

void main() {
  group('CampsiteFilter', () {
    group('Empty filter', () {
      test('has all fields null and isEmpty is true', () {
        FilterState filter = FilterState.initial();
        expect(filter.waterFilter, WaterFilter.any);
        expect(filter.campfireFilter, CampfireFilter.any);
        expect(filter.hostLanguages.length, 0);
        expect(filter.priceRange, isNull);
        expect(filter.activeFilterCount, 0);
      });
    });

    group('Active filter count', () {
      test('filter with all fields set has correct activeFilterCount', () {
        final filter = const FilterState(
          waterFilter: WaterFilter.noWater,
          campfireFilter: CampfireFilter.notAllowed,
          hostLanguages: ['EN', 'FR'],
          priceRange: RangeValues(10, 50),
        );
        expect(filter.activeFilterCount, 5);
      });

      test('filter with only one field set', () {
        final filter = const FilterState(waterFilter: WaterFilter.noWater);
        expect(filter.activeFilterCount, 1);
      });

      test('hostLanguages empty list is not counted as active filter', () {
        final filter = const FilterState(hostLanguages: []);
        expect(filter.activeFilterCount, 0);
      });

      test('hostLanguages null and empty are treated the same', () {
        final filterNull = const FilterState(hostLanguages: []);
        final filterEmpty = const FilterState(hostLanguages: []);
        expect(filterNull.activeFilterCount, 0);
        expect(filterEmpty.activeFilterCount, 0);
      });
    });

    group('copyWith', () {
      test('updates fields and resets correctly', () {
        final filter = const FilterState(
          waterFilter: WaterFilter.nearWater,
          campfireFilter: CampfireFilter.notAllowed,
          hostLanguages: ['EN'],
          priceRange: RangeValues(10, 20),
        );

        final updated = filter.copyWith(
          waterFilter: WaterFilter.noWater,
          hostLanguages: ['DE', 'FR'],
          priceRange: const RangeValues(30, 40),
        );
        expect(updated.waterFilter, WaterFilter.noWater);
        expect(updated.campfireFilter, CampfireFilter.notAllowed);
        expect(updated.hostLanguages, ['DE', 'FR']);
        expect(updated.priceRange, const RangeValues(30, 40));
      });

      test('will update only the field that is within "copyWith"', () {
        final filter = const FilterState(
          waterFilter: WaterFilter.nearWater,
          campfireFilter: CampfireFilter.notAllowed,
        );
        final updated = filter.copyWith(campfireFilter: CampfireFilter.allowed);
        expect(updated.waterFilter, WaterFilter.nearWater);
        expect(updated.campfireFilter, CampfireFilter.allowed);
      });
    });
  });
}
