import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/features/campsite/presentation/providers/campsite_provider.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/app_error_message.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/app_tagline_banner.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/responsive_campsite_view.dart';
import 'package:wander_nest/features/filters/presentation/widgets/filter_action_icon.dart';
import 'package:wander_nest/features/filters/presentation/widgets/filter_overlay_panel.dart';
import 'package:wander_nest/features/maps/presentation/screens/map_screen.dart';
import 'package:wander_nest/shared/providers/filtered_campsites_provider.dart';
import 'package:wander_nest/shared/utils/error_messages.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _handleMapIconPressed(
    BuildContext context, {
    required bool isCampsitesEmpty,
  }) {
    if (isCampsitesEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No campsites to display on the map'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MapScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campsiteListAsync = ref.watch(campsiteListProvider);
    final filteredCampsites = ref.watch(filteredCampsitesProvider);
    final isCompact = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wander Nest'),
        actions: [
          // View Map
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              _handleMapIconPressed(
                context,
                isCampsitesEmpty: filteredCampsites.isEmpty,
              );
            },
          ),
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
                    message: ErrorMessages.from(err),
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
}
