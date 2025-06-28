import 'package:flutter/material.dart';

/// [CampsiteFilter] class represents the filter criteria for campsite listings.

class CampsiteFilter {
  const CampsiteFilter({
    this.isCloseToWater,
    this.isCampFireAllowed,
    this.hostLanguages,
    this.priceRange,
  });
  final bool? isCloseToWater; // true / false / null = doesn't matter
  final bool? isCampFireAllowed; // true / false / null = doesn't matter
  final List<String>? hostLanguages; // null or empty = any
  final RangeValues? priceRange;

  CampsiteFilter copyWith({
    bool? isCloseToWater,
    bool resetCloseToWater = false,
    bool? isCampFireAllowed,
    bool resetCampFireAllowed = false,
    List<String>? hostLanguages,
    bool resetHostLanguages = false,
    RangeValues? priceRange,
    bool resetPriceRange = false,
  }) {
    return CampsiteFilter(
      isCloseToWater:
          resetCloseToWater ? null : (isCloseToWater ?? this.isCloseToWater),
      isCampFireAllowed:
          resetCampFireAllowed
              ? null
              : (isCampFireAllowed ?? this.isCampFireAllowed),
      hostLanguages:
          resetHostLanguages ? null : (hostLanguages ?? this.hostLanguages),
      priceRange: resetPriceRange ? null : (priceRange ?? this.priceRange),
    );
  }

  bool get isEmpty => !hasAnyFilter;

  int get activeFilterCount {
    int count = 0;
    if (isCloseToWater != null) count++;
    if (isCampFireAllowed != null) count++;
    if (hostLanguages != null && hostLanguages!.isNotEmpty) count++;
    if (priceRange != null) count++;
    return count;
  }

  bool get hasAnyFilter => activeFilterCount > 0;

  static const empty = CampsiteFilter();
}
