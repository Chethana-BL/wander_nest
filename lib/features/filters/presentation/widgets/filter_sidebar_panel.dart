import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/core/constants/app_icons.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/features/filters/presentation/providers/campsite_filter_notifier.dart';
import 'package:wander_nest/features/filters/presentation/providers/price_range_provider.dart';
import 'package:wander_nest/features/filters/presentation/widgets/dropdown_filter_option.dart';
import 'package:wander_nest/features/filters/presentation/widgets/language_filter_selector.dart';
import 'package:wander_nest/features/filters/presentation/widgets/price_range_slider.dart';

class FilterSidebarPanel extends ConsumerWidget {
  const FilterSidebarPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceRange = ref.watch(priceRangeProvider);
    final filter = ref.watch(campsiteFilterProvider);
    final filterNotifier = ref.read(campsiteFilterProvider.notifier);

    final currentRange = filter.priceRange ?? priceRange;

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingSM,
            vertical: AppSizes.padding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Filters', style: Theme.of(context).textTheme.headlineSmall),

              // Water tri-state toggle
              DropdownFilterOption(
                title: 'Close to Water',
                icon: AppIcons.water,
                value: filter.isCloseToWater,
                onChanged: filterNotifier.toggleWaterFilter,
              ),

              // Campfire tri-state toggle
              DropdownFilterOption(
                title: 'Campfire Allowed',
                icon: AppIcons.campfire,
                value: filter.isCampFireAllowed,
                onChanged: filterNotifier.toggleCampfireFilter,
              ),

              // Host languages multi-select
              LanguageFilterSelector(
                selectedLanguages: filter.hostLanguages ?? [],
                onSelectionChanged: (selected) {
                  filterNotifier.updateHostLanguages(
                    selected.isEmpty ? null : selected,
                  );
                },
              ),

              PriceRangeSlider(
                currentRange: currentRange,
                min: priceRange.start,
                max: priceRange.end,
                onChanged:
                    (range) =>
                        filterNotifier.updatePriceRange(range.start, range.end),
              ),

              const SizedBox(height: AppSizes.spaceLG),
              Center(
                child: ElevatedButton(
                  onPressed: filterNotifier.resetFilters,
                  child: const Text(
                    'Clear Filters',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
