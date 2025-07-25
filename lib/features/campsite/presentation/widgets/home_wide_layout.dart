import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/features/campsite/domain/entities/campsite.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/campsite_card.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/home_empty_campsite.dart';
import 'package:wander_nest/features/campsite/presentation/widgets/result_summary_banner.dart';
import 'package:wander_nest/features/filters/presentation/widgets/filter_sidebar_panel.dart';

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
    final crossAxisCount = availableWidth ~/ 300;

    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left-side filter panel
          SizedBox(
            width: filterPanelWidth.toDouble(),
            child: const FilterSidebarPanel(),
          ),

          const SizedBox(width: AppSizes.space),

          // Right-side filtered list of campsites
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.space),
                if (filteredCampsites.isNotEmpty)
                  ResultSummaryBanner(
                    totalCount: campsites.length,
                    filteredCount: filteredCampsites.length,
                  ),

                if (filteredCampsites.isEmpty)
                  const Expanded(child: NoCampsiteFound())
                else
                  Expanded(
                    child: AnimationLimiter(
                      child: GridView.builder(
                        itemCount: filteredCampsites.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: AppSizes.space,
                          crossAxisSpacing: AppSizes.space,
                          childAspectRatio: 0.95,
                        ),
                        itemBuilder: (context, index) {
                          final campsite = filteredCampsites[index];
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            columnCount: crossAxisCount,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: CampsiteCard(campsite: campsite),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
