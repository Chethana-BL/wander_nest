import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_icons.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/core/themes/app_custom_colors.dart';
import 'package:wander_nest/core/widgets/buttons/primary_button.dart';
import 'package:wander_nest/features/campsite/data/models/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/campsite_feature_badge.dart';
import 'package:wander_nest/features/maps/presentation/widgets/campsite_detail_map.dart';
import 'package:wander_nest/shared/extensions/string_extension.dart';

class CampsiteDetailScreen extends StatelessWidget {
  const CampsiteDetailScreen({super.key, required this.campsite});
  final Campsite campsite;

  static const double _maxMapWidth = 600;

  void _handleBookNowAction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Booking not implemented yet'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final campsiteName = campsite.label.capitalizeFirst();

    return Scaffold(
      appBar: AppBar(title: Text(campsiteName)),
      bottomNavigationBar: PrimaryButton(
        label: 'Book Now',
        onPressed: () => _handleBookNowAction,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;

                if (isWide) {
                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Left side (image + map)
                          Flexible(
                            flex: 3,
                            child: Column(
                              children: [
                                _CampsiteHeroImage(
                                  imageUrl: campsite.photo.secureUrl(),
                                  maxWidth: _maxMapWidth,
                                ),
                                const SizedBox(height: AppSizes.spaceLG),
                                CampsiteDetailMap(campsite: campsite),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSizes.space),
                          // Right side (info)
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _CampsitePriceText(
                                  pricePerNight: campsite.pricePerNight,
                                ),
                                const SizedBox(height: AppSizes.spaceSM),
                                _CampsiteFeatureBadges(campsite: campsite),
                                const SizedBox(height: AppSizes.spaceLG),
                                _CampsiteDescriptionText(
                                  campsiteName: campsiteName,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Fallback to vertical layout
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _CampsiteHeroImage(
                        imageUrl: campsite.photo,
                        maxWidth: _maxMapWidth,
                      ),
                      const SizedBox(height: AppSizes.spaceLG),
                      CampsiteDetailMap(campsite: campsite),
                      const SizedBox(height: AppSizes.spaceLG),
                      _CampsitePriceText(pricePerNight: campsite.pricePerNight),
                      const SizedBox(height: AppSizes.spaceSM),
                      _CampsiteFeatureBadges(campsite: campsite),
                      const SizedBox(height: AppSizes.spaceLG),
                      _CampsiteDescriptionText(
                        campsiteName: campsiteName,
                        isWide: false,
                      ),
                    ],
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

// Note: Below widges are currently local to this file for cohesion.
// Can be extracted into its own file later if reused elsewhere.

class _CampsiteHeroImage extends StatelessWidget {
  const _CampsiteHeroImage({required this.imageUrl, required this.maxWidth});
  final String imageUrl;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radius),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            imageUrl,
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
}

class _CampsitePriceText extends StatelessWidget {
  const _CampsitePriceText({required this.pricePerNight});
  final double pricePerNight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Text(
      '€${pricePerNight.toStringAsFixed(2)} / night',
      style: theme.textTheme.headlineSmall?.copyWith(
        color: colors.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _CampsiteDescriptionText extends StatelessWidget {
  const _CampsiteDescriptionText({
    required this.campsiteName,
    this.isWide = true,
  });
  final String campsiteName;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Enjoy scenic nature and outdoor adventures with our premium campsite "$campsiteName"',
      style: theme.textTheme.bodyLarge,
      textAlign: isWide ? TextAlign.start : TextAlign.center,
    );
  }
}

class _CampsiteFeatureBadges extends StatelessWidget {
  const _CampsiteFeatureBadges({required this.campsite});
  final Campsite campsite;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppCustomColors>()!;

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
