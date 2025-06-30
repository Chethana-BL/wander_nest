import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wander_nest/application/providers/filters/campsite_filter_model.dart';
import 'package:wander_nest/application/providers/filters/campsite_filter_notifier.dart';

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
      expect(filter, CampsiteFilter.empty);
    });

    test('toggleWaterFilter sets isCloseToWater', () {
      container.read(campsiteFilterProvider.notifier).toggleWaterFilter(true);
      final filter = container.read(campsiteFilterProvider);
      expect(filter.isCloseToWater, true);

      container.read(campsiteFilterProvider.notifier).toggleWaterFilter(null);
      final filter2 = container.read(campsiteFilterProvider);
      expect(filter2.isCloseToWater, null);
    });

    test('toggleCampfireFilter sets isCampFireAllowed', () {
      container
          .read(campsiteFilterProvider.notifier)
          .toggleCampfireFilter(false);
      final filter = container.read(campsiteFilterProvider);
      expect(filter.isCampFireAllowed, false);

      container
          .read(campsiteFilterProvider.notifier)
          .toggleCampfireFilter(null);
      final filter2 = container.read(campsiteFilterProvider);
      expect(filter2.isCampFireAllowed, null);
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
      expect(filter2.hostLanguages, null);
    });

    test('updatePriceRange sets priceRange', () {
      container
          .read(campsiteFilterProvider.notifier)
          .updatePriceRange(100, 500);
      final filter = container.read(campsiteFilterProvider);
      expect(filter.priceRange, const RangeValues(100, 500));

      container
          .read(campsiteFilterProvider.notifier)
          .updatePriceRange(null, null);
      final filter2 = container.read(campsiteFilterProvider);
      expect(filter2.priceRange, null);
    });

    test('setFilter replaces state', () {
      final newFilter = const CampsiteFilter(
        isCloseToWater: true,
        isCampFireAllowed: false,
        hostLanguages: ['es'],
        priceRange: RangeValues(200, 400),
      );
      container.read(campsiteFilterProvider.notifier).setFilter(newFilter);
      final filter = container.read(campsiteFilterProvider);
      expect(filter, newFilter);
    });

    test('resetFilters resets to empty', () {
      container.read(campsiteFilterProvider.notifier).toggleWaterFilter(true);
      container.read(campsiteFilterProvider.notifier).resetFilters();
      final filter = container.read(campsiteFilterProvider);
      expect(filter, CampsiteFilter.empty);
    });
  });
}
