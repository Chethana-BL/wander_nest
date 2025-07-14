// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campsite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CampsiteModelImpl _$$CampsiteModelImplFromJson(Map<String, dynamic> json) =>
    _$CampsiteModelImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      photo: json['photo'] as String,
      isCloseToWater: json['isCloseToWater'] as bool,
      isCampFireAllowed: json['isCampFireAllowed'] as bool,
      hostLanguages:
          (json['hostLanguages'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      pricePerNight: (json['pricePerNight'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      geoLocation: GeoLocation.fromJson(
        json['geoLocation'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$CampsiteModelImplToJson(_$CampsiteModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'photo': instance.photo,
      'isCloseToWater': instance.isCloseToWater,
      'isCampFireAllowed': instance.isCampFireAllowed,
      'hostLanguages': instance.hostLanguages,
      'pricePerNight': instance.pricePerNight,
      'createdAt': instance.createdAt.toIso8601String(),
      'geoLocation': instance.geoLocation,
    };
