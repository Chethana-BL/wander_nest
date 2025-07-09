import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:wander_nest/features/campsite/data/models/campsite.dart';
import 'package:wander_nest/features/maps/domain/entities/map_cluster.dart';
import 'package:wander_nest/features/maps/presentation/providers/map_state.dart';

// Controls the state of the map including zoom, center, and cluster data
class MapControllerNotifier extends StateNotifier<MapState> {
  MapControllerNotifier()
    : super(const MapState(clusters: [], currentZoom: 10.0));

  static const double _minZoomForClustering = 13.0;

  // Controls the state of the map including zoom, center, and cluster data
  void updateClusters(List<Campsite> campsites, double zoom) {
    state = state.copyWith(currentZoom: zoom);

    if (campsites.isEmpty) {
      state = state.copyWith(clusters: []);
      return;
    }

    final center = _calculateCenter(campsites);
    final clusters = _performDynamicClustering(campsites, zoom);

    state = state.copyWith(
      clusters: clusters,
      center: center,
      isLoading: false,
      error: null,
    );
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String error) {
    state = state.copyWith(error: error, isLoading: false);
  }

  // Calculates the geographic center (average lat/lng) of given campsites
  LatLng _calculateCenter(List<Campsite> campsites) {
    final totalLat = campsites.fold(0.0, (sum, c) => sum + c.geoLocation.lat);
    final totalLng = campsites.fold(0.0, (sum, c) => sum + c.geoLocation.long);
    return LatLng(totalLat / campsites.length, totalLng / campsites.length);
  }

  // Groups campsites into clusters based on zoom level and spatial proximity
  List<MapCluster> _performDynamicClustering(
    List<Campsite> campsites,
    double zoom,
  ) {
    final double gridSize = _calculateGridSize(zoom);
    final Map<String, List<Campsite>> gridClusters = {};

    for (final campsite in campsites) {
      final key = _getGridKey(
        campsite.geoLocation.lat,
        campsite.geoLocation.long,
        gridSize,
      );
      gridClusters.putIfAbsent(key, () => []).add(campsite);
    }

    final List<MapCluster> clusters = [];

    // Create clusters or single markers depending on number of campsites and zoom
    for (final group in gridClusters.values) {
      if (group.isEmpty) continue;

      // If single campsite and zoomed in enough, show as individual marker
      if (group.length == 1 && zoom >= _minZoomForClustering) {
        clusters.add(
          MapCluster(
            position: LatLng(
              group.first.geoLocation.lat,
              group.first.geoLocation.long,
            ),
            campsites: group,
            isCluster: false,
          ),
        );
      } else {
        // Otherwise, show as a cluster with center position
        final center = _calculateCenter(group);
        clusters.add(
          MapCluster(
            position: center,
            campsites: group,
            isCluster: group.length > 1,
          ),
        );
      }
    }

    return clusters;
  }

  // Determines grid size dynamically based on zoom level to control clustering precision
  double _calculateGridSize(double zoom) {
    if (zoom <= 3) return 10.0;
    if (zoom <= 5) return 1.0;
    if (zoom <= 7) return 0.5;
    if (zoom <= 9) return 0.3;
    if (zoom <= 10) return 0.2;
    if (zoom <= 13) return 0.1;
    return 0.1; // Default for higher zoom levels
  }

  // Calculates a grid key (string) to group campsites into spatial buckets
  String _getGridKey(double lat, double lng, double gridSize) {
    final latGrid = (lat / gridSize).floor();
    final lngGrid = (lng / gridSize).floor();
    return '$latGrid,$lngGrid';
  }
}
