import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/core/constants/app_icons.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/features/filters/domain/entities/filter_enums.dart';
import 'package:wander_nest/features/filters/presentation/providers/campsite_filter_notifier.dart';
import 'package:wander_nest/features/filters/presentation/providers/filter_options_providers.dart';
import 'package:wander_nest/features/filters/presentation/widgets/dropdown_filter_option.dart';
import 'package:wander_nest/features/filters/presentation/widgets/language_filter_selector.dart';
import 'package:wander_nest/features/filters/presentation/widgets/price_range_slider.dart';
import 'package:wander_nest/shared/extensions/string_extension.dart';

class FilterSidebarPanel extends ConsumerWidget {
  const FilterSidebarPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceRange = ref.watch(priceRangeProvider);
    final filter = ref.watch(campsiteFilterProvider);
    final filterNotifier = ref.read(campsiteFilterProvider.notifier);
    final allLanguages = ref.watch(hostLanguagesProvider);

    final currentRange = filter.priceRange ?? priceRange;

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingSM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Filters', style: Theme.of(context).textTheme.headlineSmall),

              // Water tri-state toggle
              DropdownFilterOption<WaterFilter>(
                title: 'Close to Water',
                icon: AppIcons.water,
                value: filter.waterFilter,
                options: WaterFilter.values,
                labelBuilder: (v) => v.name.capitalizeFirst(),
                onChanged: filterNotifier.setWaterFilter,
              ),

              // Campfire tri-state toggle
              DropdownFilterOption<CampfireFilter>(
                title: 'Campfire Allowed',
                icon: AppIcons.campfire,
                value: filter.campfireFilter,
                options: CampfireFilter.values,
                labelBuilder: (v) => v.name.capitalizeFirst(),
                onChanged: filterNotifier.setCampfireFilter,
              ),

              // Host languages multi-select
              LanguageFilterSelector(
                allLanguages: allLanguages,
                selectedLanguages: filter.hostLanguages,
                onSelectionChanged: (selected) {
                  filterNotifier.updateHostLanguages(
                    selected.isNotEmpty ? selected : [],
                  );
                },
              ),

              PriceRangeSlider(
                currentRange: currentRange,
                min: priceRange.start,
                max: priceRange.end,
                onChanged: (range) => filterNotifier.setPriceRange(range),
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
