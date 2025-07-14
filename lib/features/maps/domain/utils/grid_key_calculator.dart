/// Generates spatial grid keys for grouping campsites into clusters.
///
/// Helps to map geographic coordinates into grid cells based on current zoom level.
class GridKeyCalculator {
  /// Returns the grid size (in degrees) depending on the current map zoom level.
  static double getGridSize(double zoom) {
    if (zoom <= 3) return 10.0;
    if (zoom <= 5) return 1.0;
    if (zoom <= 7) return 0.5;
    if (zoom <= 9) return 0.3;
    if (zoom <= 10) return 0.2;
    if (zoom <= 13) return 0.1;
    return 0.1;
  }

  /// A unique key for the grid cell with the given lat/lng for grouping campsites.
  static String getKey({
    required double lat,
    required double lng,
    required double gridSize,
  }) {
    final latGrid = (lat / gridSize).floor();
    final lngGrid = (lng / gridSize).floor();
    return '$latGrid,$lngGrid';
  }
}
