import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_enums.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_state.dart';

/// [campsiteFilterProvider] is a StateNotifierProvider that provides an instance of [CampsiteFilterNotifier].
final campsiteFilterProvider =
    StateNotifierProvider<CampsiteFilterNotifier, FilterState>(
      (ref) => CampsiteFilterNotifier(),
    );

/// [CampsiteFilterNotifier] is a StateNotifier that manages the state of campsite filters.
class CampsiteFilterNotifier extends StateNotifier<FilterState> {
  CampsiteFilterNotifier() : super(FilterState.initial());

  void setWaterFilter(WaterFilter filter) {
    state = state.copyWith(waterFilter: filter);
  }

  void setCampfireFilter(CampfireFilter campfire) {
    state = state.copyWith(campfireFilter: campfire);
  }

  void updateHostLanguages(List<String> languages) {
    state = state.copyWith(hostLanguages: languages);
  }

  void setPriceRange(RangeValues? range) {
    state = state.copyWith(priceRange: range);
  }

  void setFilter(FilterState filter) {
    state = filter;
  }

  void resetFilters() {
    state = FilterState.initial();
  }
}
