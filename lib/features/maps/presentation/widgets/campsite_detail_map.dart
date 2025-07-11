import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/maps/presentation/widgets/campsite_marker_icon.dart';

class CampsiteDetailMap extends StatelessWidget {
  const CampsiteDetailMap({super.key, required this.campsite});

  final Campsite campsite;
  static const double _maxMapWidth = 600;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxMapWidth),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radius),
            child: FlutterMap(
              options: MapOptions(
                minZoom: 3.0,
                maxZoom: 18.0,
                initialCenter: campsite.geoLocation.toLatLng,
              ),
              children: [
                TileLayer(
                  tileProvider:
                      kIsWeb
                          ? CancellableNetworkTileProvider()
                          : NetworkTileProvider(),
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.wanderNest',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: AppSizes.iconXL,
                      height: AppSizes.iconXL,
                      point: campsite.geoLocation.toLatLng,
                      child: const CampsiteMarkerIcon(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
