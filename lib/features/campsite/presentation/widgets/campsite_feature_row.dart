import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_icons.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/core/themes/app_custom_colors.dart';
import 'package:wander_nest/features/campsite/data/models/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/campsite_feature_badge.dart';

class CampsiteFeatureRow extends StatelessWidget {
  const CampsiteFeatureRow({
    super.key,
    required this.campsite,
    required this.availableWidth,
  });

  final Campsite campsite;
  final double availableWidth;

  bool get _showText => availableWidth > 310;

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<AppCustomColors>()!;

    return Wrap(
      spacing: AppSizes.spaceSM,
      runSpacing: AppSizes.spaceXS,
      children: [
        CampsiteFeatureBadge(
          icon: AppIcons.water,
          available: campsite.isCloseToWater,
          labelAvailable: 'Water',
          labelUnavailable: 'No Water',
          availableColor: customColors.water,
          showText: _showText,
        ),
        CampsiteFeatureBadge(
          icon: AppIcons.campfire,
          available: campsite.isCampFireAllowed,
          labelAvailable: 'Campfire',
          labelUnavailable: 'No Fire',
          availableColor: customColors.fire,

          showText: _showText,
        ),
        if (campsite.hostLanguages.isNotEmpty)
          CampsiteFeatureBadge(
            icon: AppIcons.language,
            available: true,
            labelAvailable: campsite.hostLanguages.join(', ').toUpperCase(),
            labelUnavailable: '',
            availableColor: customColors.hostLanguage,
            showText: true,
          ),
      ],
    );
  }
}
