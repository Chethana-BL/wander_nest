import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/application/providers/campsite_provider.dart';
import 'package:wander_nest/presentation/widgets/campsites_listing/campsite_list_view.dart';

class CampsiteListScreen extends ConsumerWidget {
  const CampsiteListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campsiteListAsync = ref.watch(campsiteListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wander Nest'),
      ), //Discover, Filter & Book Serene Campsites Easily ),
      body: campsiteListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: ${err.toString()}')),
        data: (_) {
          final sortedCampsites = ref.watch(sortedCampsiteListProvider);

          return CampsiteListView(campsites: sortedCampsites);
        },
      ),
    );
  }
}
