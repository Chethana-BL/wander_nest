import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:wander_nest/data/models/campsite.dart';

/// Represents either a single campsite marker or a cluster of campsites
/// on the map, with its position and contained campsites.
@immutable
class MapCluster {
  const MapCluster({
    required this.position,
    required this.campsites,
    required this.isCluster,
  });
  final LatLng position;
  final List<Campsite> campsites;
  final bool isCluster;

  int get count => campsites.length;

  Campsite get firstCampsite => campsites.first;
}
