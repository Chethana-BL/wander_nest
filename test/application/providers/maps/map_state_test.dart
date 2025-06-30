import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:wander_nest/application/providers/map/map_state.dart';
import 'package:wander_nest/data/models/map_cluster.dart';

void main() {
  group('MapState', () {
    final cluster1 = const MapCluster(
      position: LatLng(1.0, 2.0),
      campsites: [],
      isCluster: true,
    );
    final cluster2 = const MapCluster(
      position: LatLng(3.0, 4.0),
      campsites: [],
      isCluster: false,
    );
    final clusters = [cluster1, cluster2];
    final center = const LatLng(10.0, 20.0);

    test('should create MapState with required fields', () {
      final state = MapState(clusters: clusters, currentZoom: 5.0);

      expect(state.clusters, clusters);
      expect(state.currentZoom, 5.0);
      expect(state.center, isNull);
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
    });

    test('should support copyWith for all fields', () {
      final state = MapState(
        clusters: clusters,
        currentZoom: 5.0,
        center: center,
        isLoading: true,
        error: null,
      );

      final newClusters = [cluster1];
      final newCenter = const LatLng(30.0, 40.0);

      final copied = state.copyWith(
        clusters: newClusters,
        currentZoom: 10.0,
        center: newCenter,
        isLoading: false,
        error: 'some error',
      );

      expect(copied.clusters, newClusters);
      expect(copied.currentZoom, 10.0);
      expect(copied.center, newCenter);
      expect(copied.isLoading, isFalse);
      expect(copied.error, 'some error');
    });

    test('copyWith returns same values if no arguments are passed', () {
      final state = MapState(
        clusters: clusters,
        currentZoom: 5.0,
        center: center,
        isLoading: true,
        error: 'Error',
      );

      final copied = state.copyWith();

      expect(copied.clusters, state.clusters);
      expect(copied.currentZoom, state.currentZoom);
      expect(copied.center, state.center);
      expect(copied.isLoading, state.isLoading);
      expect(copied.error, state.error);
    });
  });
}
