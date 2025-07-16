import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/shared/extensions/color_extensions.dart';

class ResultSummaryBanner extends StatelessWidget {
  const ResultSummaryBanner({
    super.key,
    required this.totalCount,
    required this.filteredCount,
    this.showIfUnfiltered = true,
  });

  final int totalCount;
  final int filteredCount;
  final bool showIfUnfiltered;

  bool get isFiltered => filteredCount != totalCount;

  @override
  Widget build(BuildContext context) {
    if (!isFiltered && !showIfUnfiltered) return const SizedBox.shrink();

    final textTheme = Theme.of(context).textTheme;

    final label =
        isFiltered
            ? '$filteredCount of $totalCount campsites match your filters'
            : '$totalCount campsites available';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: AppSizes.paddingSM),
      color: Theme.of(context).colorScheme.primary.alphaF(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingSM),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isFiltered ? Icons.filter_alt_outlined : Icons.info_outline,
              size: AppSizes.icon,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: AppSizes.spaceSM),
            Text(label, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
