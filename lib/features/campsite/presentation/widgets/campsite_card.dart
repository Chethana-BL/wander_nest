import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/navigation/campsite_routes.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/campsite_feature_row.dart';

class CampsiteCard extends StatelessWidget {
  const CampsiteCard({super.key, required this.campsite});

  final Campsite campsite;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppSizes.spaceSM),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius),
      ),
      elevation: AppSizes.elevation,
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth;

          return InkWell(
            onTap: () => navigateToCampsiteDetail(context, campsite),
            borderRadius: BorderRadius.circular(AppSizes.radius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    campsite.photoUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => const Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(AppSizes.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        campsite.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),

                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: AppSizes.spaceSM),

                      // Price
                      Text(
                        '€${campsite.pricePerNight.toStringAsFixed(2)} / night',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: AppSizes.spaceSM),

                      // Feature indicators
                      CampsiteFeatureRow(
                        campsite: campsite,
                        availableWidth: cardWidth,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
