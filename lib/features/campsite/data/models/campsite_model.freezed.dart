// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'campsite_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CampsiteModel _$CampsiteModelFromJson(Map<String, dynamic> json) {
  return _CampsiteModel.fromJson(json);
}

/// @nodoc
mixin _$CampsiteModel {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get photo => throw _privateConstructorUsedError;
  bool get isCloseToWater => throw _privateConstructorUsedError;
  bool get isCampFireAllowed => throw _privateConstructorUsedError;
  List<String> get hostLanguages => throw _privateConstructorUsedError;
  double get pricePerNight => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  GeoLocation get geoLocation => throw _privateConstructorUsedError;

  /// Serializes this CampsiteModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CampsiteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CampsiteModelCopyWith<CampsiteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampsiteModelCopyWith<$Res> {
  factory $CampsiteModelCopyWith(
    CampsiteModel value,
    $Res Function(CampsiteModel) then,
  ) = _$CampsiteModelCopyWithImpl<$Res, CampsiteModel>;
  @useResult
  $Res call({
    String id,
    String label,
    String photo,
    bool isCloseToWater,
    bool isCampFireAllowed,
    List<String> hostLanguages,
    double pricePerNight,
    DateTime createdAt,
    GeoLocation geoLocation,
  });
}

/// @nodoc
class _$CampsiteModelCopyWithImpl<$Res, $Val extends CampsiteModel>
    implements $CampsiteModelCopyWith<$Res> {
  _$CampsiteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CampsiteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? photo = null,
    Object? isCloseToWater = null,
    Object? isCampFireAllowed = null,
    Object? hostLanguages = null,
    Object? pricePerNight = null,
    Object? createdAt = null,
    Object? geoLocation = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            label:
                null == label
                    ? _value.label
                    : label // ignore: cast_nullable_to_non_nullable
                        as String,
            photo:
                null == photo
                    ? _value.photo
                    : photo // ignore: cast_nullable_to_non_nullable
                        as String,
            isCloseToWater:
                null == isCloseToWater
                    ? _value.isCloseToWater
                    : isCloseToWater // ignore: cast_nullable_to_non_nullable
                        as bool,
            isCampFireAllowed:
                null == isCampFireAllowed
                    ? _value.isCampFireAllowed
                    : isCampFireAllowed // ignore: cast_nullable_to_non_nullable
                        as bool,
            hostLanguages:
                null == hostLanguages
                    ? _value.hostLanguages
                    : hostLanguages // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            pricePerNight:
                null == pricePerNight
                    ? _value.pricePerNight
                    : pricePerNight // ignore: cast_nullable_to_non_nullable
                        as double,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            geoLocation:
                null == geoLocation
                    ? _value.geoLocation
                    : geoLocation // ignore: cast_nullable_to_non_nullable
                        as GeoLocation,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CampsiteModelImplCopyWith<$Res>
    implements $CampsiteModelCopyWith<$Res> {
  factory _$$CampsiteModelImplCopyWith(
    _$CampsiteModelImpl value,
    $Res Function(_$CampsiteModelImpl) then,
  ) = __$$CampsiteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String label,
    String photo,
    bool isCloseToWater,
    bool isCampFireAllowed,
    List<String> hostLanguages,
    double pricePerNight,
    DateTime createdAt,
    GeoLocation geoLocation,
  });
}

/// @nodoc
class __$$CampsiteModelImplCopyWithImpl<$Res>
    extends _$CampsiteModelCopyWithImpl<$Res, _$CampsiteModelImpl>
    implements _$$CampsiteModelImplCopyWith<$Res> {
  __$$CampsiteModelImplCopyWithImpl(
    _$CampsiteModelImpl _value,
    $Res Function(_$CampsiteModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CampsiteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? photo = null,
    Object? isCloseToWater = null,
    Object? isCampFireAllowed = null,
    Object? hostLanguages = null,
    Object? pricePerNight = null,
    Object? createdAt = null,
    Object? geoLocation = null,
  }) {
    return _then(
      _$CampsiteModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
        photo:
            null == photo
                ? _value.photo
                : photo // ignore: cast_nullable_to_non_nullable
                    as String,
        isCloseToWater:
            null == isCloseToWater
                ? _value.isCloseToWater
                : isCloseToWater // ignore: cast_nullable_to_non_nullable
                    as bool,
        isCampFireAllowed:
            null == isCampFireAllowed
                ? _value.isCampFireAllowed
                : isCampFireAllowed // ignore: cast_nullable_to_non_nullable
                    as bool,
        hostLanguages:
            null == hostLanguages
                ? _value._hostLanguages
                : hostLanguages // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        pricePerNight:
            null == pricePerNight
                ? _value.pricePerNight
                : pricePerNight // ignore: cast_nullable_to_non_nullable
                    as double,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        geoLocation:
            null == geoLocation
                ? _value.geoLocation
                : geoLocation // ignore: cast_nullable_to_non_nullable
                    as GeoLocation,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CampsiteModelImpl implements _CampsiteModel {
  const _$CampsiteModelImpl({
    required this.id,
    required this.label,
    required this.photo,
    required this.isCloseToWater,
    required this.isCampFireAllowed,
    required final List<String> hostLanguages,
    required this.pricePerNight,
    required this.createdAt,
    required this.geoLocation,
  }) : _hostLanguages = hostLanguages;

  factory _$CampsiteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CampsiteModelImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String photo;
  @override
  final bool isCloseToWater;
  @override
  final bool isCampFireAllowed;
  final List<String> _hostLanguages;
  @override
  List<String> get hostLanguages {
    if (_hostLanguages is EqualUnmodifiableListView) return _hostLanguages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hostLanguages);
  }

  @override
  final double pricePerNight;
  @override
  final DateTime createdAt;
  @override
  final GeoLocation geoLocation;

  @override
  String toString() {
    return 'CampsiteModel(id: $id, label: $label, photo: $photo, isCloseToWater: $isCloseToWater, isCampFireAllowed: $isCampFireAllowed, hostLanguages: $hostLanguages, pricePerNight: $pricePerNight, createdAt: $createdAt, geoLocation: $geoLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampsiteModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.isCloseToWater, isCloseToWater) ||
                other.isCloseToWater == isCloseToWater) &&
            (identical(other.isCampFireAllowed, isCampFireAllowed) ||
                other.isCampFireAllowed == isCampFireAllowed) &&
            const DeepCollectionEquality().equals(
              other._hostLanguages,
              _hostLanguages,
            ) &&
            (identical(other.pricePerNight, pricePerNight) ||
                other.pricePerNight == pricePerNight) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.geoLocation, geoLocation) ||
                other.geoLocation == geoLocation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    label,
    photo,
    isCloseToWater,
    isCampFireAllowed,
    const DeepCollectionEquality().hash(_hostLanguages),
    pricePerNight,
    createdAt,
    geoLocation,
  );

  /// Create a copy of CampsiteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CampsiteModelImplCopyWith<_$CampsiteModelImpl> get copyWith =>
      __$$CampsiteModelImplCopyWithImpl<_$CampsiteModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CampsiteModelImplToJson(this);
  }
}

abstract class _CampsiteModel implements CampsiteModel {
  const factory _CampsiteModel({
    required final String id,
    required final String label,
    required final String photo,
    required final bool isCloseToWater,
    required final bool isCampFireAllowed,
    required final List<String> hostLanguages,
    required final double pricePerNight,
    required final DateTime createdAt,
    required final GeoLocation geoLocation,
  }) = _$CampsiteModelImpl;

  factory _CampsiteModel.fromJson(Map<String, dynamic> json) =
      _$CampsiteModelImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  String get photo;
  @override
  bool get isCloseToWater;
  @override
  bool get isCampFireAllowed;
  @override
  List<String> get hostLanguages;
  @override
  double get pricePerNight;
  @override
  DateTime get createdAt;
  @override
  GeoLocation get geoLocation;

  /// Create a copy of CampsiteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CampsiteModelImplCopyWith<_$CampsiteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
