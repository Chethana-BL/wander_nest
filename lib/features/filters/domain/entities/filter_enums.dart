/// Water Filter
enum WaterFilter { nearWater, noWater, any }

extension WaterFilterExtension on WaterFilter {
  String get name {
    switch (this) {
      case WaterFilter.nearWater:
        return 'Yes';
      case WaterFilter.noWater:
        return 'No';
      case WaterFilter.any:
        return 'Any';
    }
  }
}

/// Campfire Filter
enum CampfireFilter { allowed, notAllowed, any }

extension CampfireFilterExtension on CampfireFilter {
  String get name {
    switch (this) {
      case CampfireFilter.allowed:
        return 'Yes';
      case CampfireFilter.notAllowed:
        return 'No';
      case CampfireFilter.any:
        return 'Any';
    }
  }
}
