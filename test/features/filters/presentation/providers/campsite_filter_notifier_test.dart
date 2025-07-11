import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_enums.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_state.dart';
import 'package:wander_nest/features/filters/presentation/providers/campsite_filter_notifier.dart';

void main() {
  group('CampsiteFilterNotifier', () {
    late ProviderContainer container;
    setUp(() {
      container = ProviderContainer();
    });
    tearDown(() {
      container.dispose();
    });

    test('initial state is CampsiteFilter.empty', () {
      final filter = container.read(campsiteFilterProvider);
      expect(filter, FilterState.initial());
    });

    test('toggleWaterFilter sets isCloseToWater', () {
      container
          .read(campsiteFilterProvider.notifier)
          .setWaterFilter(WaterFilter.nearWater);
      final filter = container.read(campsiteFilterProvider);
      expect(filter.waterFilter, WaterFilter.nearWater);

      container
          .read(campsiteFilterProvider.notifier)
          .setWaterFilter(WaterFilter.any);
      final filter2 = container.read(campsiteFilterProvider);
      expect(filter2.waterFilter, WaterFilter.any);
    });

    test('toggleCampfireFilter sets isCampFireAllowed', () {
      container
          .read(campsiteFilterProvider.notifier)
          .setCampfireFilter(CampfireFilter.notAllowed);
      final filter = container.read(campsiteFilterProvider);
      expect(filter.campfireFilter, CampfireFilter.notAllowed);

      container
          .read(campsiteFilterProvider.notifier)
          .setCampfireFilter(CampfireFilter.any);
      final filter2 = container.read(campsiteFilterProvider);
      expect(filter2.campfireFilter, CampfireFilter.any);
    });

    test('updateHostLanguages sets hostLanguages', () {
      container.read(campsiteFilterProvider.notifier).updateHostLanguages([
        'en',
        'fr',
      ]);
      final filter = container.read(campsiteFilterProvider);
      expect(filter.hostLanguages, ['en', 'fr']);

      container.read(campsiteFilterProvider.notifier).updateHostLanguages([]);
      final filter2 = container.read(campsiteFilterProvider);
      expect(filter2.hostLanguages, []);
    });

    test('updatePriceRange sets priceRange', () {
      container
          .read(campsiteFilterProvider.notifier)
          .setPriceRange(const RangeValues(100, 500));
      final filter = container.read(campsiteFilterProvider);
      expect(filter.priceRange, const RangeValues(100, 500));

      container.read(campsiteFilterProvider.notifier).setPriceRange(null);
      final filter2 = container.read(campsiteFilterProvider);
      expect(filter2.priceRange, null);
    });

    test('setFilter replaces state', () {
      final newFilter = const FilterState(
        waterFilter: WaterFilter.nearWater,
        campfireFilter: CampfireFilter.notAllowed,
        hostLanguages: ['es'],
        priceRange: RangeValues(200, 400),
      );
      container.read(campsiteFilterProvider.notifier).setFilter(newFilter);
      final filter = container.read(campsiteFilterProvider);
      expect(filter, newFilter);
    });

    test('resetFilters resets to empty', () {
      container
          .read(campsiteFilterProvider.notifier)
          .setWaterFilter(WaterFilter.nearWater);
      container.read(campsiteFilterProvider.notifier).resetFilters();
      final filter = container.read(campsiteFilterProvider);
      expect(filter, FilterState.initial());
    });
  });
}
