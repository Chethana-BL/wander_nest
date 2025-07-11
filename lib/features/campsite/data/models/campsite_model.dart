import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wander_nest/features/campsite/data/models/geo_location.dart';

part 'campsite_model.freezed.dart';
part 'campsite_model.g.dart';

@freezed
class CampsiteModel with _$CampsiteModel {
  const factory CampsiteModel({
    required String id,
    required String label,
    required String photo,
    required bool isCloseToWater,
    required bool isCampFireAllowed,
    required List<String> hostLanguages,
    required double pricePerNight,
    required DateTime createdAt,
    required GeoLocation geoLocation,
  }) = _CampsiteModel;

  factory CampsiteModel.fromJson(Map<String, dynamic> json) =>
      _$CampsiteModelFromJson(json);
}
