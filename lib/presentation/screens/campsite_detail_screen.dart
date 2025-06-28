import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_icons.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/core/themes/app_custom_colors.dart';
import 'package:wander_nest/data/models/campsite.dart';
import 'package:wander_nest/presentation/widgets/common/campsite_feature_badge.dart';
import 'package:wander_nest/shared/extensions/string_extension.dart';

class CampsiteDetailScreen extends StatelessWidget {
  const CampsiteDetailScreen({super.key, required this.campsite});
  final Campsite campsite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;
    final customColors = Theme.of(context).extension<AppCustomColors>()!;

    final campsiteName = campsite.label.capitalizeFirst();

    return Scaffold(
      appBar: AppBar(title: Text(campsiteName)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radius),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      campsite.photo.secureUrl(),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => const Center(
                            child: Icon(Icons.image_not_supported),
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.space),
                // Price
                Text(
                  '€${campsite.pricePerNight.toStringAsFixed(2)} / night',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: color.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceSM),
                // Feature badges
                Wrap(
                  spacing: AppSizes.spaceSM,
                  runSpacing: AppSizes.spaceSM,
                  children: [
                    // Water badge
                    CampsiteFeatureBadge(
                      icon: AppIcons.waterFlowing,
                      available: campsite.isCloseToWater,
                      labelAvailable: 'Water Nearby',
                      labelUnavailable: 'No Water',
                      availableColor: customColors.water,
                    ),
                    // Campfire badge
                    CampsiteFeatureBadge(
                      icon: AppIcons.campfire,
                      available: campsite.isCampFireAllowed,
                      labelAvailable: 'Campfire Allowed',
                      labelUnavailable: 'No Campfire',
                      availableColor: customColors.fire,
                    ),
                    // Host languages
                    ...campsite.hostLanguages.map(
                      (lang) => CampsiteFeatureBadge(
                        icon: AppIcons.language,
                        available: true,
                        labelAvailable: lang.toUpperCase(),
                        labelUnavailable: '',
                        availableColor: customColors.hostLanguage,
                        showUnavailableText: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.space),
                Text(
                  'Enjoy scenic nature and outdoor adventures with our premium campsite "$campsiteName".',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
