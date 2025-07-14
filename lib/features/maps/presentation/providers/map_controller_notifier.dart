import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/maps/domain/usecases/cluster_campsites.dart';
import 'package:wander_nest/features/maps/domain/utils/geo_utils.dart';
import 'package:wander_nest/features/maps/presentation/providers/map_state.dart';

/// Controls the state of the map including zoom, center, and clustering logic.
///
/// Delegates spatial clustering of campsites to the domain-level
/// [ClusterCampsites] to keep presentation logic clean and focused.
///
class MapControllerNotifier extends StateNotifier<MapState> {
  MapControllerNotifier()
    : super(const MapState(clusters: [], currentZoom: 10.0));

  final ClusterCampsites _clusterCampsites = ClusterCampsites();

  // Updates the map state by clustering campsites based on the given zoom level.
  void updateClusters(List<Campsite> campsites, double zoom) {
    state = state.copyWith(currentZoom: zoom);

    if (campsites.isEmpty) {
      state = state.copyWith(clusters: []);
      return;
    }

    /// Map center based on the geographic average of all campsites
    final center = GeoUtils.calculateCenter(campsites);

    /// Group campsites into clusters or show them individually, depending on zoom.
    final clusters = _clusterCampsites(campsites, zoom);

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
}
