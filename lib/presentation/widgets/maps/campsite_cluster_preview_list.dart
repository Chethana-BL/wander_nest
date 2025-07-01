import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_icons.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/core/themes/app_custom_colors.dart';
import 'package:wander_nest/data/models/campsite.dart';
import 'package:wander_nest/presentation/navigation/campsite_navigation.dart';
import 'package:wander_nest/presentation/screens/campsite_detail_screen.dart';
import 'package:wander_nest/shared/extensions/color_extensions.dart';
import 'package:wander_nest/shared/extensions/string_extension.dart';

class CampsiteClusterPreviewList extends StatelessWidget {
  const CampsiteClusterPreviewList({super.key, required this.campsites});

  final List<Campsite> campsites;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final customColors = theme.extension<AppCustomColors>()!;

    return Container(
      height: 300,
      padding: const EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.alphaF(0.05),
            blurRadius: AppSizes.spaceSM,
            offset: const Offset(0, AppSizes.spaceXS),
          ),
        ],
      ),
      child: ListView.separated(
        itemCount: campsites.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSizes.spaceSM),
        itemBuilder: (context, index) {
          final campsite = campsites[index];

          return Material(
            borderRadius: BorderRadius.circular(AppSizes.radius),
            color: colorScheme.surface,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSizes.radius),
              onTap: () {
                Navigator.of(context).pop(); // Close the bottom sheet
                // Navigate to the campsite detail screen
                navigateToCampsiteDetail(context, campsite);
              },
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.padding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnail Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.radiusSM),
                      child: Image.network(
                        campsite.photo.secureUrl(),
                        width: AppSizes.iconXXL,
                        height: AppSizes.iconXXL,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => const Icon(
                              Icons.image_not_supported,
                              size: AppSizes.iconLG,
                            ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.space),
                    // Label & Price
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            campsite.label.capitalizeFirst(),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppSizes.spaceXS),
                          Text(
                            '€${campsite.pricePerNight.toStringAsFixed(2)} / night',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Features (Water, Campfire)
                    Row(
                      children: [
                        Icon(
                          AppIcons.water,
                          size: AppSizes.iconLG,
                          color:
                              campsite.isCloseToWater
                                  ? customColors.water
                                  : customColors.disabled,
                        ),
                        const SizedBox(width: AppSizes.spaceSM),
                        Icon(
                          AppIcons.campfire,
                          size: AppSizes.iconLG,
                          color:
                              campsite.isCampFireAllowed
                                  ? customColors.fire
                                  : customColors.disabled,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
