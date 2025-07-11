import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/features/maps/domain/entities/map_cluster.dart';
import 'package:wander_nest/features/maps/presentation/providers/map_controller_notifier.dart';
import 'package:wander_nest/features/maps/presentation/providers/map_state.dart';

final mapControllerProvider =
    StateNotifierProvider<MapControllerNotifier, MapState>(
      (ref) => MapControllerNotifier(),
    );

// Watches filtered campsites and triggers cluster generation on zoom change
final mapClustersProvider = Provider<AsyncValue<List<MapCluster>>>((ref) {
  final mapState = ref.watch(mapControllerProvider);
  return AsyncValue.data(mapState.clusters);
});
