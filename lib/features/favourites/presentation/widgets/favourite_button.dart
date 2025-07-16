import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander_nest/core/constants/app_icons.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/shared/extensions/color_extensions.dart';
import '../providers/favourites_provider.dart';

class FavouriteButton extends ConsumerWidget {
  const FavouriteButton({
    super.key,
    required this.campsiteId,
    this.size = AppSizes.icon,
  });

  final String campsiteId;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref.watch(favouritesProvider).contains(campsiteId);

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.alphaF(0.4),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.alphaF(0.1), blurRadius: 4)],
      ),
      child: IconButton(
        icon: Icon(
          isFav ? AppIcons.favorite : AppIcons.favoriteBorder,
          color: isFav ? Colors.redAccent : Colors.white.alphaF(0.8),
          size: size,
        ),
        tooltip: isFav ? 'Remove from favourites' : 'Add to favourites',
        onPressed:
            () => ref
                .read(favouritesProvider.notifier)
                .toggleFavourite(campsiteId),
      ),
    );
  }
}
