import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_icons.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/core/themes/app_custom_colors.dart';
import 'package:wander_nest/data/models/campsite.dart';
import 'package:wander_nest/presentation/widgets/common/campsite_feature_badge.dart';
import 'package:wander_nest/presentation/widgets/maps/campsite_detail_map.dart';
import 'package:wander_nest/shared/extensions/string_extension.dart';

class CampsiteDetailScreen extends StatelessWidget {
  const CampsiteDetailScreen({super.key, required this.campsite});
  final Campsite campsite;

  static const double _maxMapWidth = 600;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final customColors = Theme.of(context).extension<AppCustomColors>()!;
    final campsiteName = campsite.label.capitalizeFirst();

    return Scaffold(
      appBar: AppBar(title: Text(campsiteName)),
      bottomNavigationBar: _buildBookNowButton(context, colors),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeroImage(campsite),
                const SizedBox(height: AppSizes.spaceLG),
                CampsiteDetailMap(campsite: campsite),
                const SizedBox(height: AppSizes.spaceLG),
                // --- Price ---
                Text(
                  '€${campsite.pricePerNight.toStringAsFixed(2)} / night',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSizes.spaceSM),
                // --- Features ---
                _buildFeatureBadges(campsite, customColors),
                const SizedBox(height: AppSizes.spaceLG),
                Text(
                  'Enjoy scenic nature and outdoor adventures with our premium campsite "$campsiteName"',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBookNowButton(BuildContext context, ColorScheme colors) {
    return SafeArea(
      minimum: const EdgeInsets.all(AppSizes.padding),
      child: SizedBox(
        height: AppSizes.buttonHeight,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Handle booking action
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Booking not implemented yet'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radius),
            ),
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
            textStyle: Theme.of(context).textTheme.titleMedium,
          ),
          child: const Text('Book Now'),
        ),
      ),
    );
  }

  Widget _buildHeroImage(Campsite campsite) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: _maxMapWidth),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radius),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            campsite.photo.secureUrl(),
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder:
                (_, __, ___) =>
                    const Center(child: Icon(Icons.image_not_supported)),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureBadges(Campsite campsite, AppCustomColors customColors) {
    return Wrap(
      spacing: AppSizes.spaceSM,
      runSpacing: AppSizes.spaceSM,
      alignment: WrapAlignment.center,
      children: [
        CampsiteFeatureBadge(
          icon: AppIcons.waterFlowing,
          available: campsite.isCloseToWater,
          labelAvailable: 'Water Nearby',
          labelUnavailable: 'No Water',
          availableColor: customColors.water,
        ),
        CampsiteFeatureBadge(
          icon: AppIcons.campfire,
          available: campsite.isCampFireAllowed,
          labelAvailable: 'Campfire Allowed',
          labelUnavailable: 'No Campfire',
          availableColor: customColors.fire,
        ),
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
    );
  }
}
