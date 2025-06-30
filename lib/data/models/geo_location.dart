import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

@immutable
class GeoLocation {
  const GeoLocation({required this.lat, required this.long});

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    final rawLat = (json['lat'] as num?)?.toDouble() ?? 0.0;
    final rawLong = (json['long'] as num?)?.toDouble() ?? 0.0;

    final (lat, long) = _normalizeCoordinates(rawLat, rawLong);
    return GeoLocation(lat: lat, long: long);
  }

  final double lat;
  final double long;

  LatLng get toLatLng => LatLng(lat, long);

  /// Validates and converts potentially invalid coordinates into WGS84 format.
  /// If coordinates are already valid, returns them as is.
  /// If not, assumes they're in Web Mercator (meters) and converts them to degrees.
  static (double, double) _normalizeCoordinates(double rawLat, double rawLong) {
    const validLatRange = (-90.0, 90.0);
    const validLongRange = (-180.0, 180.0);

    if (rawLat >= validLatRange.$1 &&
        rawLat <= validLatRange.$2 &&
        rawLong >= validLongRange.$1 &&
        rawLong <= validLongRange.$2) {
      // Already valid
      return (rawLat, rawLong);
    }

    const R = 6378137.0; // Earth's radius in meters

    final normalizedLong = (rawLong / R) * (180 / pi);
    final normalizedLat = (2 * atan(exp(rawLat / R)) - pi / 2) * (180 / pi);

    // Alternative: Convert the meters back to UTM coordinates
    // Note: UTM conversion requires a specific zone, here we assume zone 32T for simplicity.
    // final utmResult = UTM.fromUtm(
    //   easting: rawLngMeters,
    //   northing: rawLatMeters,
    //   zoneNumber: 32,
    //   zoneLetter: 'T',
    // );

    return (normalizedLat, normalizedLong);
  }
}
