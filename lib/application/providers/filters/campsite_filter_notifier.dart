import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'campsite_filter_model.dart';

/// [campsiteFilterProvider] is a StateNotifierProvider that provides an instance of [CampsiteFilterNotifier].
final campsiteFilterProvider =
    StateNotifierProvider<CampsiteFilterNotifier, CampsiteFilter>(
      (ref) => CampsiteFilterNotifier(),
    );

/// [CampsiteFilterNotifier] is a StateNotifier that manages the state of campsite filters.
class CampsiteFilterNotifier extends StateNotifier<CampsiteFilter> {
  CampsiteFilterNotifier() : super(CampsiteFilter.empty);

  void toggleWaterFilter(bool? value) {
    state = state.copyWith(
      isCloseToWater: value,
      resetCloseToWater: value == null,
    );
  }

  void toggleCampfireFilter(bool? value) {
    state = state.copyWith(
      isCampFireAllowed: value,
      resetCampFireAllowed: value == null,
    );
  }

  void updateHostLanguages(List<String>? languages) {
    final isReset = languages == null || languages.isEmpty;
    state = state.copyWith(
      hostLanguages: languages,
      resetHostLanguages: isReset,
    );
  }

  void updatePriceRange(double? min, double? max) {
    final range = (min != null && max != null) ? RangeValues(min, max) : null;
    state = state.copyWith(priceRange: range, resetPriceRange: range == null);
  }

  void setFilter(CampsiteFilter filter) {
    state = filter;
  }

  void resetFilters() {
    state = CampsiteFilter.empty;
  }
}
