import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/features/campsite/presentation/navigation/campsite_routes.dart';
import 'package:wander_nest/features/maps/domain/entities/map_cluster.dart';
import 'package:wander_nest/features/maps/presentation/providers/map_providers.dart';
import 'package:wander_nest/features/maps/presentation/widgets/campsite_cluster_preview_list.dart';
import 'package:wander_nest/features/maps/presentation/widgets/campsite_marker_icon.dart';
import 'package:wander_nest/features/maps/presentation/widgets/cluster_count_marker.dart';
import 'package:wander_nest/shared/providers/filtered_campsites_provider.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late final MapController _mapController;
  bool _hasMovedToInitialCenter = false;
  bool _initialClusterSetupDone = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapControllerProvider);
    final clustersAsync = ref.watch(mapClustersProvider);
    final campsites = ref.read(filteredCampsitesProvider);

    final mapStateCenter = mapState.center;
    final currentZoom = mapState.currentZoom;

    // Use a fallback center if null: San Francisco
    final currentCenter = mapStateCenter ?? const LatLng(37.7749, -122.4194);

    if (!_initialClusterSetupDone || !_hasMovedToInitialCenter) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        // Move to initial center only once
        if (!_hasMovedToInitialCenter && mapStateCenter != null) {
          _mapController.move(mapStateCenter, currentZoom);
          _hasMovedToInitialCenter = true;
        }

        // Initialize clusters only once
        if (!_initialClusterSetupDone) {
          ref
              .read(mapControllerProvider.notifier)
              .updateClusters(campsites, currentZoom);
          _initialClusterSetupDone = true;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Campsites Map')),
      body: clustersAsync.when(
        data: (clusters) {
          return FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: currentCenter,
              initialZoom: currentZoom,
              maxZoom: 18,
              minZoom: 3,
              onPositionChanged: (position, hasGesture) {
                _onMapPositionChanged(position.zoom);
              },
            ),
            children: [
              TileLayer(
                tileProvider:
                    kIsWeb
                        ? CancellableNetworkTileProvider()
                        : NetworkTileProvider(),
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.wanderNest',
                maxZoom: 18,
              ),
              MarkerLayer(markers: _buildMarkers(clusters)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, _) =>
                Center(child: Text('Error loading campsites: $error')),
      ),
    );
  }

  List<Marker> _buildMarkers(List<MapCluster> clusters) {
    return clusters.map((cluster) {
      return Marker(
        point: cluster.position,
        width: AppSizes.iconXL,
        height: AppSizes.iconXL,
        child: GestureDetector(
          onTap: () => _onClusterTap(cluster),
          child:
              cluster.isCluster
                  ? ClusterCountMarker(cluster.count)
                  : const CampsiteMarkerIcon(),
        ),
      );
    }).toList();
  }

  // Update clusters if zoom level has changed
  void _onMapPositionChanged(double zoom) {
    final mapState = ref.read(mapControllerProvider);
    final campsites = ref.read(filteredCampsitesProvider);

    if ((zoom - mapState.currentZoom).abs() > 0.1) {
      ref.read(mapControllerProvider.notifier).updateClusters(campsites, zoom);
    }
  }

  void _onClusterTap(MapCluster cluster) {
    if (cluster.isCluster && cluster.count > 1) {
      // Multiple campsite - Show a modal bottom sheet listing the campsites in the cluster
      showModalBottomSheet(
        context: context,
        builder:
            (context) =>
                CampsiteClusterPreviewList(campsites: cluster.campsites),
      );
    } else {
      // Single campsite - navigate to detail or show popup
      navigateToCampsiteDetail(context, cluster.firstCampsite);
    }
  }
}
