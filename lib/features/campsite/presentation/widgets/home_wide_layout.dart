import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/providers/search_providers.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/campsite_card.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/home_empty_campsite.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/result_summary_banner.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/search_bar.dart';
import 'package:wander_nest/features/filters/presentation/widgets/filter_sidebar_panel.dart';
import 'package:wander_nest/shared/widgets/animated_lists.dart';

class HomeWideLayout extends ConsumerWidget {
  const HomeWideLayout({
    super.key,
    required this.width,
    required this.campsites,
    required this.filteredCampsites,
  });

  final List<Campsite> campsites;
  final List<Campsite> filteredCampsites;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterPanelWidth = 300;
    final availableWidth = width - filterPanelWidth;
    final search = ref.watch(searchQueryProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left-side filter panel
        SizedBox(
          width: filterPanelWidth.toDouble(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SearchBarWidget(
                onChanged:
                    (value) =>
                        ref.read(searchQueryProvider.notifier).state = value,
                searchText: search,
              ),
              const Expanded(child: FilterSidebarPanel()),
            ],
          ),
        ),

        const SizedBox(width: AppSizes.space),

        // Right-side filtered list of campsites
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (filteredCampsites.isNotEmpty)
                ResultSummaryBanner(
                  totalCount: campsites.length,
                  filteredCount: filteredCampsites.length,
                ),

              if (filteredCampsites.isEmpty)
                const Expanded(child: NoCampsiteFound())
              else
                Expanded(
                  child: AnimatedGridView<Campsite>(
                    items: filteredCampsites,
                    maxWidth: availableWidth,
                    itemBuilder:
                        (context, campsite) => CampsiteCard(campsite: campsite),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
