// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FilterState {
  WaterFilter get waterFilter => throw _privateConstructorUsedError;
  CampfireFilter get campfireFilter => throw _privateConstructorUsedError;
  List<String> get hostLanguages => throw _privateConstructorUsedError;
  RangeValues? get priceRange => throw _privateConstructorUsedError;

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FilterStateCopyWith<FilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterStateCopyWith<$Res> {
  factory $FilterStateCopyWith(
    FilterState value,
    $Res Function(FilterState) then,
  ) = _$FilterStateCopyWithImpl<$Res, FilterState>;
  @useResult
  $Res call({
    WaterFilter waterFilter,
    CampfireFilter campfireFilter,
    List<String> hostLanguages,
    RangeValues? priceRange,
  });
}

/// @nodoc
class _$FilterStateCopyWithImpl<$Res, $Val extends FilterState>
    implements $FilterStateCopyWith<$Res> {
  _$FilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? waterFilter = null,
    Object? campfireFilter = null,
    Object? hostLanguages = null,
    Object? priceRange = freezed,
  }) {
    return _then(
      _value.copyWith(
            waterFilter:
                null == waterFilter
                    ? _value.waterFilter
                    : waterFilter // ignore: cast_nullable_to_non_nullable
                        as WaterFilter,
            campfireFilter:
                null == campfireFilter
                    ? _value.campfireFilter
                    : campfireFilter // ignore: cast_nullable_to_non_nullable
                        as CampfireFilter,
            hostLanguages:
                null == hostLanguages
                    ? _value.hostLanguages
                    : hostLanguages // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            priceRange:
                freezed == priceRange
                    ? _value.priceRange
                    : priceRange // ignore: cast_nullable_to_non_nullable
                        as RangeValues?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FilterStateImplCopyWith<$Res>
    implements $FilterStateCopyWith<$Res> {
  factory _$$FilterStateImplCopyWith(
    _$FilterStateImpl value,
    $Res Function(_$FilterStateImpl) then,
  ) = __$$FilterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    WaterFilter waterFilter,
    CampfireFilter campfireFilter,
    List<String> hostLanguages,
    RangeValues? priceRange,
  });
}

/// @nodoc
class __$$FilterStateImplCopyWithImpl<$Res>
    extends _$FilterStateCopyWithImpl<$Res, _$FilterStateImpl>
    implements _$$FilterStateImplCopyWith<$Res> {
  __$$FilterStateImplCopyWithImpl(
    _$FilterStateImpl _value,
    $Res Function(_$FilterStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? waterFilter = null,
    Object? campfireFilter = null,
    Object? hostLanguages = null,
    Object? priceRange = freezed,
  }) {
    return _then(
      _$FilterStateImpl(
        waterFilter:
            null == waterFilter
                ? _value.waterFilter
                : waterFilter // ignore: cast_nullable_to_non_nullable
                    as WaterFilter,
        campfireFilter:
            null == campfireFilter
                ? _value.campfireFilter
                : campfireFilter // ignore: cast_nullable_to_non_nullable
                    as CampfireFilter,
        hostLanguages:
            null == hostLanguages
                ? _value._hostLanguages
                : hostLanguages // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        priceRange:
            freezed == priceRange
                ? _value.priceRange
                : priceRange // ignore: cast_nullable_to_non_nullable
                    as RangeValues?,
      ),
    );
  }
}

/// @nodoc

class _$FilterStateImpl implements _FilterState {
  const _$FilterStateImpl({
    this.waterFilter = WaterFilter.any,
    this.campfireFilter = CampfireFilter.any,
    final List<String> hostLanguages = const <String>[],
    this.priceRange,
  }) : _hostLanguages = hostLanguages;

  @override
  @JsonKey()
  final WaterFilter waterFilter;
  @override
  @JsonKey()
  final CampfireFilter campfireFilter;
  final List<String> _hostLanguages;
  @override
  @JsonKey()
  List<String> get hostLanguages {
    if (_hostLanguages is EqualUnmodifiableListView) return _hostLanguages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hostLanguages);
  }

  @override
  final RangeValues? priceRange;

  @override
  String toString() {
    return 'FilterState(waterFilter: $waterFilter, campfireFilter: $campfireFilter, hostLanguages: $hostLanguages, priceRange: $priceRange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterStateImpl &&
            (identical(other.waterFilter, waterFilter) ||
                other.waterFilter == waterFilter) &&
            (identical(other.campfireFilter, campfireFilter) ||
                other.campfireFilter == campfireFilter) &&
            const DeepCollectionEquality().equals(
              other._hostLanguages,
              _hostLanguages,
            ) &&
            (identical(other.priceRange, priceRange) ||
                other.priceRange == priceRange));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    waterFilter,
    campfireFilter,
    const DeepCollectionEquality().hash(_hostLanguages),
    priceRange,
  );

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterStateImplCopyWith<_$FilterStateImpl> get copyWith =>
      __$$FilterStateImplCopyWithImpl<_$FilterStateImpl>(this, _$identity);
}

abstract class _FilterState implements FilterState {
  const factory _FilterState({
    final WaterFilter waterFilter,
    final CampfireFilter campfireFilter,
    final List<String> hostLanguages,
    final RangeValues? priceRange,
  }) = _$FilterStateImpl;

  @override
  WaterFilter get waterFilter;
  @override
  CampfireFilter get campfireFilter;
  @override
  List<String> get hostLanguages;
  @override
  RangeValues? get priceRange;

  /// Create a copy of FilterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterStateImplCopyWith<_$FilterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
