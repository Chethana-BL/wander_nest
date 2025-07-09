import 'package:flutter/material.dart';

import 'package:latlong2/latlong.dart';
import 'package:wander_nest/features/maps/domain/entities/map_cluster.dart';

/// Represents the current state of the map, including zoom level,
/// clusters/markers, center position, loading status, and any errors.
@immutable
class MapState {
  const MapState({
    required this.clusters,
    required this.currentZoom,
    this.center,
    this.isLoading = false,
    this.error,
  });
  final List<MapCluster> clusters;
  final double currentZoom;
  final LatLng? center;
  final bool isLoading;
  final String? error;

  MapState copyWith({
    List<MapCluster>? clusters,
    double? currentZoom,
    LatLng? center,
    bool? isLoading,
    String? error,
  }) {
    return MapState(
      clusters: clusters ?? this.clusters,
      currentZoom: currentZoom ?? this.currentZoom,
      center: center ?? this.center,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
