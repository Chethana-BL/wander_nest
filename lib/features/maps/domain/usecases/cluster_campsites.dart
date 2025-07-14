import 'package:latlong2/latlong.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/maps/domain/entities/map_cluster.dart';
import 'package:wander_nest/features/maps/domain/utils/geo_utils.dart';
import 'package:wander_nest/features/maps/domain/utils/grid_key_calculator.dart';

/// Groups a list of campsites into spatial clusters based on zoom level.
///
/// - At higher zoom levels, nearby campsites are grouped together into clusters.
/// - At closer zooms, individual campsites are shown separately for more precision.
class ClusterCampsites {
  static const double _minZoomForClustering = 13.0;

  /// Clusters the given campsites into groups or single markers based on zoom level.
  List<MapCluster> call(List<Campsite> campsites, double zoom) {
    final double gridSize = GridKeyCalculator.getGridSize(zoom);
    final Map<String, List<Campsite>> gridClusters = {};

    for (final campsite in campsites) {
      final key = GridKeyCalculator.getKey(
        lat: campsite.geoLocation.lat,
        lng: campsite.geoLocation.long,
        gridSize: gridSize,
      );
      gridClusters.putIfAbsent(key, () => []).add(campsite);
    }

    final List<MapCluster> clusters = [];

    for (final group in gridClusters.values) {
      if (group.isEmpty) continue;

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
        final center = GeoUtils.calculateCenter(group);
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
}
