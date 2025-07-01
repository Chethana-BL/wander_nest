import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/application/providers/campsite_provider.dart';
import 'package:wander_nest/application/providers/filters/filtered_campsites_provider.dart';
import 'package:wander_nest/presentation/screens/map_screen.dart';
import 'package:wander_nest/presentation/widgets/filter_panel/filter_action_icon.dart';
import 'package:wander_nest/presentation/widgets/filter_panel/filter_overlay_panel.dart';
import 'package:wander_nest/presentation/widgets/home/app_error_message.dart';
import 'package:wander_nest/presentation/widgets/home/app_tagline_banner.dart';
import 'package:wander_nest/presentation/widgets/home/responsive_campsite_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campsiteListAsync = ref.watch(campsiteListProvider);
    final filteredCampsites = ref.watch(filteredCampsitesProvider);
    final isCompact = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wander Nest'),
        actions: [
          _buildMapIconButton(context, filteredCampsites.isEmpty),
          if (isCompact)
            /// Compact view: Show filter icon with badge
            FilterActionIcon(
              onPressed:
                  () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => const FilterOverlayPanel(),
                  ),
            ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppTaglineBanner(),
          Expanded(
            child: campsiteListAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (err, _) => AppErrorMessage(
                    message: 'Error: ${err.toString()}',
                    onRetry: () => ref.refresh(campsiteListProvider),
                  ),
              data: (allCampsites) {
                return ResponsiveCampsiteView(
                  campsites: allCampsites,
                  filteredCampsites: filteredCampsites,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapIconButton(BuildContext context, bool isCampsitesEmpty) {
    return IconButton(
      icon: const Icon(Icons.map),
      onPressed: () {
        if (isCampsitesEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No campsites to display on map'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MapScreen()),
        );
      },
    );
  }
}
