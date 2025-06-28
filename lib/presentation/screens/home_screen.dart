import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/application/providers/campsite_provider.dart';
import 'package:wander_nest/application/providers/filters/filtered_campsites_provider.dart';
import 'package:wander_nest/presentation/widgets/filter_panel/filter_action_icon.dart';
import 'package:wander_nest/presentation/widgets/filter_panel/filter_overlay_panel.dart';
import 'package:wander_nest/presentation/widgets/home/app_error_message.dart';
import 'package:wander_nest/presentation/widgets/home/responsive_campsite_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campsiteListAsync = ref.watch(campsiteListProvider);
    final isCompact = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wander Nest'),
        actions: [
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
      body: campsiteListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (err, _) => AppErrorMessage(
              message: 'Error: ${err.toString()}',
              onRetry: () => ref.refresh(campsiteListProvider),
            ),
        data: (allCampsites) {
          final filteredCampsites = ref.watch(filteredCampsitesProvider);

          return ResponsiveCampsiteView(
            campsites: allCampsites,
            filteredCampsites: filteredCampsites,
          );
        },
      ),
    );
  }
}
