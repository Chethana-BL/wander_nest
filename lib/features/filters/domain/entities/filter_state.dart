import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_enums.dart';

part 'filter_state.freezed.dart';

/// [FilterState] class represents the filter criteria for campsite listings.

@freezed
class FilterState with _$FilterState {
  const factory FilterState({
    @Default(WaterFilter.any) WaterFilter waterFilter,
    @Default(CampfireFilter.any) CampfireFilter campfireFilter,
    @Default(<String>[]) List<String> hostLanguages,
    RangeValues? priceRange,
  }) = _FilterState;

  factory FilterState.initial() => const FilterState(
    waterFilter: WaterFilter.any,
    campfireFilter: CampfireFilter.any,
    hostLanguages: [],
    priceRange: null,
  );
}

extension FilterStateX on FilterState {
  bool get isDefault =>
      waterFilter == WaterFilter.any &&
      campfireFilter == CampfireFilter.any &&
      hostLanguages.isEmpty &&
      priceRange == null;

  /// Returns count of active filters
  int get activeFilterCount {
    var count = 0;
    if (waterFilter != WaterFilter.any) count++;
    if (campfireFilter != CampfireFilter.any) count++;
    count += hostLanguages.length;
    if (priceRange != null) count++;
    return count;
  }
}
