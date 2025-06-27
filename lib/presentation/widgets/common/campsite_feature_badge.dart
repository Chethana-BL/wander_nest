import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/core/themes/app_custom_colors.dart';

class CampsiteFeatureBadge extends StatelessWidget {
  const CampsiteFeatureBadge({
    super.key,
    required this.icon,
    required this.available,
    required this.labelAvailable,
    required this.labelUnavailable,
    required this.availableColor,
    this.showText = true,
    this.showUnavailableText = true,
  });

  final IconData icon;
  final bool available;
  final String labelAvailable;
  final String labelUnavailable;
  final Color availableColor;
  final bool showText;
  final bool showUnavailableText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customColors = theme.extension<AppCustomColors>()!;

    final Color displayColor =
        available ? availableColor : customColors.disabled;
    final Color borderColor =
        available ? availableColor : customColors.disabled;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSM,
        vertical: AppSizes.paddingXS,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(AppSizes.radiusSM),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppSizes.iconSM, color: displayColor),
          if (showText &&
              (available || (!available && showUnavailableText))) ...[
            const SizedBox(width: AppSizes.spaceXS),
            Text(
              available ? labelAvailable : labelUnavailable,
              style: theme.textTheme.labelMedium?.copyWith(color: displayColor),
            ),
          ],
        ],
      ),
    );
  }
}
