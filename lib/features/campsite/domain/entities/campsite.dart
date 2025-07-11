import 'package:wander_nest/features/campsite/data/models/campsite_model.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';
import 'package:wander_nest/shared/extensions/string_extension.dart';

class Campsite {
  factory Campsite.fromModel(CampsiteModel m) => Campsite(
    id: m.id,
    name: m.label.capitalizeFirst(),
    photoUrl: m.photo.secureUrl(),
    isCloseToWater: m.isCloseToWater,
    isCampFireAllowed: m.isCampFireAllowed,
    hostLanguages: m.hostLanguages,
    pricePerNight: m.pricePerNight,
    geoLocation: m.geoLocation,
  );

  Campsite({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.isCloseToWater,
    required this.isCampFireAllowed,
    required this.hostLanguages,
    required this.pricePerNight,
    required this.geoLocation,
  });

  final String id;
  final String name;
  final String photoUrl;
  final bool isCloseToWater;
  final bool isCampFireAllowed;
  final List<String> hostLanguages;
  final double pricePerNight;
  final GeoLocation geoLocation;
}
