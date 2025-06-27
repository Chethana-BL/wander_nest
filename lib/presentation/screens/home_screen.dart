import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/application/providers/campsite_provider.dart';
import 'package:wander_nest/presentation/widgets/home/responsive_campsite_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campsiteListAsync = ref.watch(campsiteListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Wander Nest')),
      body: campsiteListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (err, _) => Center(
              child: Text('Error: ${err.toString()}'),
            ), //TODO: Create Error Widget
        data: (_) {
          final sortedCampsites = ref.watch(sortedCampsiteListProvider);

          return ResponsiveCampsiteView(campsites: sortedCampsites);
        },
      ),
    );
  }
}
