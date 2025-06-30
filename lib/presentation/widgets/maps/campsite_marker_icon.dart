import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_icons.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';

class CampsiteMarkerIcon extends StatelessWidget {
  const CampsiteMarkerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      AppIcons.mapMarker,
      color: Colors.green,
      size: AppSizes.iconLG,
    );
  }
}
