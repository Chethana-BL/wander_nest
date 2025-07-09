import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';

part 'campsite.freezed.dart';
part 'campsite.g.dart';

@freezed
class Campsite with _$Campsite {
  const factory Campsite({
    required String id,
    required String label,
    required String photo,
    required bool isCloseToWater,
    required bool isCampFireAllowed,
    required List<String> hostLanguages,
    required double pricePerNight,
    required DateTime createdAt,
    required GeoLocation geoLocation,
  }) = _Campsite;

  const Campsite._();

  factory Campsite.fromJson(Map<String, dynamic> json) =>
      _$CampsiteFromJson(json);
}
