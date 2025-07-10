import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:wander_nest/features/campsite/data/models/campsite.dart';

part 'map_cluster.freezed.dart';

/// Represents either a single campsite marker or a cluster of campsites
/// on the map, with its position and contained campsites.
@freezed
class MapCluster with _$MapCluster {
  const factory MapCluster({
    required LatLng position,
    required List<Campsite> campsites,
    required bool isCluster,
  }) = _MapCluster;

  const MapCluster._();

  int get count => campsites.length;

  Campsite get firstCampsite => campsites.first;
}
