import 'package:flutter/material.dart';
import 'package:wander_nest/data/models/campsite.dart';

class CampsiteListView extends StatelessWidget {
  const CampsiteListView({super.key, required this.campsites});
  final List<Campsite> campsites;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: campsites.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final campsite = campsites[index];

        return ListTile(
          title: Text(campsite.label),
          onTap: () {
            // TODO: Navigate to campsite detail or show more info
          },
        );
      },
    );
  }
}
