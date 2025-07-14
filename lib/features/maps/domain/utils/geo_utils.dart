import 'package:latlong2/latlong.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';

/// Provides geographic utility functions for map-related calculations.
class GeoUtils {
  /// Calculates the geographic center (average lat and long) of a list of campsites.
  static LatLng calculateCenter(List<Campsite> campsites) {
    if (campsites.isEmpty) {
      throw ArgumentError('Campsites list cannot be empty');
    }

    final totalLat = campsites.fold(0.0, (sum, c) => sum + c.geoLocation.lat);
    final totalLng = campsites.fold(0.0, (sum, c) => sum + c.geoLocation.long);
    return LatLng(totalLat / campsites.length, totalLng / campsites.length);
  }
}
