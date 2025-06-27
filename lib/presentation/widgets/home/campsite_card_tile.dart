import 'package:flutter/material.dart';
import 'package:wander_nest/core/constants/app_sizes.dart';
import 'package:wander_nest/data/models/campsite.dart';
import 'package:wander_nest/presentation/screens/campsite_detail_screen.dart';
import 'package:wander_nest/presentation/widgets/home/campsite_card.dart';

class CampsiteCardTile extends StatelessWidget {
  const CampsiteCardTile({super.key, required this.campsite});

  final Campsite campsite;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CampsiteDetailScreen(campsite: campsite),
          ),
        );
      },
      borderRadius: BorderRadius.circular(AppSizes.radius),
      child: CampsiteCard(campsite: campsite),
    );
  }
}
