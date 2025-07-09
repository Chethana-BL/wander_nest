import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/features/maps/domain/entities/map_cluster.dart';
import 'package:wander_nest/features/maps/presentation/providers/map_controller_notifier.dart';
import 'package:wander_nest/features/maps/presentation/providers/map_state.dart';
import 'package:wander_nest/shared/providers/filtered_campsites_provider.dart';

final mapControllerProvider =
    StateNotifierProvider<MapControllerNotifier, MapState>(
      (ref) => MapControllerNotifier(),
    );

// Watches filtered campsites and triggers cluster generation on zoom change
final mapClustersProvider = Provider<AsyncValue<List<MapCluster>>>((ref) {
  final campsites = ref.watch(filteredCampsitesProvider);
  final mapState = ref.watch(mapControllerProvider);

  if (campsites.isEmpty) {
    return const AsyncValue.data([]);
  }

  // Trigger cluster update after build
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ref
        .read(mapControllerProvider.notifier)
        .updateClusters(campsites, mapState.currentZoom);
  });

  return AsyncValue.data(mapState.clusters);
});
