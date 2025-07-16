import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';

/// A generic animated grid view that adapts the number of columns based on [maxWidth].
/// Use [itemBuilder] to build the widget for each item.
///
/// Example usage:
/// ```dart
/// AnimatedGridView<Campsite>(
///   items: campsiteList,
///   maxWidth: MediaQuery.of(context).size.width,
///   itemBuilder: (context, campsite) => CampsiteCard(campsite: campsite),
/// )
/// ```
class AnimatedGridView<T> extends StatelessWidget {
  const AnimatedGridView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.maxWidth,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = maxWidth ~/ 300;

    return AnimationLimiter(
      child: GridView.builder(
        padding: const EdgeInsets.all(AppSizes.padding),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: AppSizes.space,
          crossAxisSpacing: AppSizes.space,
          childAspectRatio: 0.95,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: crossAxisCount,
            child: ScaleAnimation(
              child: FadeInAnimation(child: itemBuilder(context, item)),
            ),
          );
        },
      ),
    );
  }
}

/// A generic animated list view with staggered animations.
/// Use [itemBuilder] to build the widget for each item.
///
/// Example usage:
/// ```dart
/// AnimatedListView<Campsite>(
///   items: campsiteList,
///   itemBuilder: (context, campsite) => CampsiteCard(campsite: campsite),
/// )
/// ```
class AnimatedListView<T> extends StatelessWidget {
  const AnimatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.separated(
        padding: const EdgeInsets.all(AppSizes.padding),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSizes.space),
        itemBuilder: (context, index) {
          final item = items[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 400),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: itemBuilder(context, item)),
            ),
          );
        },
      ),
    );
  }
}
