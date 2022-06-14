// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'motor_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MotorStateTearOff {
  const _$MotorStateTearOff();

// ignore: unused_element
  MotorInitial loadInitial() {
    return const MotorInitial();
  }

// ignore: unused_element
  MotorLoading loadLoading() {
    return const MotorLoading();
  }

// ignore: unused_element
  MotorLoaded loadLoaded(MotorModel item) {
    return MotorLoaded(
      item,
    );
  }

// ignore: unused_element
  MotorFailure loadFailure(String error) {
    return MotorFailure(
      error,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MotorState = _$MotorStateTearOff();

/// @nodoc
mixin _$MotorState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(MotorModel item),
    @required TResult loadFailure(String error),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loadInitial(),
    TResult loadLoading(),
    TResult loadLoaded(MotorModel item),
    TResult loadFailure(String error),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loadInitial(MotorInitial value),
    @required TResult loadLoading(MotorLoading value),
    @required TResult loadLoaded(MotorLoaded value),
    @required TResult loadFailure(MotorFailure value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loadInitial(MotorInitial value),
    TResult loadLoading(MotorLoading value),
    TResult loadLoaded(MotorLoaded value),
    TResult loadFailure(MotorFailure value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $MotorStateCopyWith<$Res> {
  factory $MotorStateCopyWith(
          MotorState value, $Res Function(MotorState) then) =
      _$MotorStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$MotorStateCopyWithImpl<$Res> implements $MotorStateCopyWith<$Res> {
  _$MotorStateCopyWithImpl(this._value, this._then);

  final MotorState _value;
  // ignore: unused_field
  final $Res Function(MotorState) _then;
}

/// @nodoc
abstract class $MotorInitialCopyWith<$Res> {
  factory $MotorInitialCopyWith(
          MotorInitial value, $Res Function(MotorInitial) then) =
      _$MotorInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$MotorInitialCopyWithImpl<$Res> extends _$MotorStateCopyWithImpl<$Res>
    implements $MotorInitialCopyWith<$Res> {
  _$MotorInitialCopyWithImpl(
      MotorInitial _value, $Res Function(MotorInitial) _then)
      : super(_value, (v) => _then(v as MotorInitial));

  @override
  MotorInitial get _value => super._value as MotorInitial;
}

/// @nodoc
class _$MotorInitial implements MotorInitial {
  const _$MotorInitial();

  @override
  String toString() {
    return 'MotorState.loadInitial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is MotorInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(MotorModel item),
    @required TResult loadFailure(String error),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailure != null);
    return loadInitial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loadInitial(),
    TResult loadLoading(),
    TResult loadLoaded(MotorModel item),
    TResult loadFailure(String error),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadInitial != null) {
      return loadInitial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loadInitial(MotorInitial value),
    @required TResult loadLoading(MotorLoading value),
    @required TResult loadLoaded(MotorLoaded value),
    @required TResult loadFailure(MotorFailure value),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailure != null);
    return loadInitial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loadInitial(MotorInitial value),
    TResult loadLoading(MotorLoading value),
    TResult loadLoaded(MotorLoaded value),
    TResult loadFailure(MotorFailure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadInitial != null) {
      return loadInitial(this);
    }
    return orElse();
  }
}

abstract class MotorInitial implements MotorState {
  const factory MotorInitial() = _$MotorInitial;
}

/// @nodoc
abstract class $MotorLoadingCopyWith<$Res> {
  factory $MotorLoadingCopyWith(
          MotorLoading value, $Res Function(MotorLoading) then) =
      _$MotorLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$MotorLoadingCopyWithImpl<$Res> extends _$MotorStateCopyWithImpl<$Res>
    implements $MotorLoadingCopyWith<$Res> {
  _$MotorLoadingCopyWithImpl(
      MotorLoading _value, $Res Function(MotorLoading) _then)
      : super(_value, (v) => _then(v as MotorLoading));

  @override
  MotorLoading get _value => super._value as MotorLoading;
}

/// @nodoc
class _$MotorLoading implements MotorLoading {
  const _$MotorLoading();

  @override
  String toString() {
    return 'MotorState.loadLoading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is MotorLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(MotorModel item),
    @required TResult loadFailure(String error),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailure != null);
    return loadLoading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loadInitial(),
    TResult loadLoading(),
    TResult loadLoaded(MotorModel item),
    TResult loadFailure(String error),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadLoading != null) {
      return loadLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loadInitial(MotorInitial value),
    @required TResult loadLoading(MotorLoading value),
    @required TResult loadLoaded(MotorLoaded value),
    @required TResult loadFailure(MotorFailure value),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailure != null);
    return loadLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loadInitial(MotorInitial value),
    TResult loadLoading(MotorLoading value),
    TResult loadLoaded(MotorLoaded value),
    TResult loadFailure(MotorFailure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadLoading != null) {
      return loadLoading(this);
    }
    return orElse();
  }
}

abstract class MotorLoading implements MotorState {
  const factory MotorLoading() = _$MotorLoading;
}

/// @nodoc
abstract class $MotorLoadedCopyWith<$Res> {
  factory $MotorLoadedCopyWith(
          MotorLoaded value, $Res Function(MotorLoaded) then) =
      _$MotorLoadedCopyWithImpl<$Res>;
  $Res call({MotorModel item});
}

/// @nodoc
class _$MotorLoadedCopyWithImpl<$Res> extends _$MotorStateCopyWithImpl<$Res>
    implements $MotorLoadedCopyWith<$Res> {
  _$MotorLoadedCopyWithImpl(
      MotorLoaded _value, $Res Function(MotorLoaded) _then)
      : super(_value, (v) => _then(v as MotorLoaded));

  @override
  MotorLoaded get _value => super._value as MotorLoaded;

  @override
  $Res call({
    Object item = freezed,
  }) {
    return _then(MotorLoaded(
      item == freezed ? _value.item : item as MotorModel,
    ));
  }
}

/// @nodoc
class _$MotorLoaded implements MotorLoaded {
  const _$MotorLoaded(this.item) : assert(item != null);

  @override
  final MotorModel item;

  @override
  String toString() {
    return 'MotorState.loadLoaded(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MotorLoaded &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(item);

  @JsonKey(ignore: true)
  @override
  $MotorLoadedCopyWith<MotorLoaded> get copyWith =>
      _$MotorLoadedCopyWithImpl<MotorLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(MotorModel item),
    @required TResult loadFailure(String error),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailure != null);
    return loadLoaded(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loadInitial(),
    TResult loadLoading(),
    TResult loadLoaded(MotorModel item),
    TResult loadFailure(String error),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadLoaded != null) {
      return loadLoaded(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loadInitial(MotorInitial value),
    @required TResult loadLoading(MotorLoading value),
    @required TResult loadLoaded(MotorLoaded value),
    @required TResult loadFailure(MotorFailure value),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailure != null);
    return loadLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loadInitial(MotorInitial value),
    TResult loadLoading(MotorLoading value),
    TResult loadLoaded(MotorLoaded value),
    TResult loadFailure(MotorFailure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadLoaded != null) {
      return loadLoaded(this);
    }
    return orElse();
  }
}

abstract class MotorLoaded implements MotorState {
  const factory MotorLoaded(MotorModel item) = _$MotorLoaded;

  MotorModel get item;
  @JsonKey(ignore: true)
  $MotorLoadedCopyWith<MotorLoaded> get copyWith;
}

/// @nodoc
abstract class $MotorFailureCopyWith<$Res> {
  factory $MotorFailureCopyWith(
          MotorFailure value, $Res Function(MotorFailure) then) =
      _$MotorFailureCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class _$MotorFailureCopyWithImpl<$Res> extends _$MotorStateCopyWithImpl<$Res>
    implements $MotorFailureCopyWith<$Res> {
  _$MotorFailureCopyWithImpl(
      MotorFailure _value, $Res Function(MotorFailure) _then)
      : super(_value, (v) => _then(v as MotorFailure));

  @override
  MotorFailure get _value => super._value as MotorFailure;

  @override
  $Res call({
    Object error = freezed,
  }) {
    return _then(MotorFailure(
      error == freezed ? _value.error : error as String,
    ));
  }
}

/// @nodoc
class _$MotorFailure implements MotorFailure {
  const _$MotorFailure(this.error) : assert(error != null);

  @override
  final String error;

  @override
  String toString() {
    return 'MotorState.loadFailure(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is MotorFailure &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  $MotorFailureCopyWith<MotorFailure> get copyWith =>
      _$MotorFailureCopyWithImpl<MotorFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(MotorModel item),
    @required TResult loadFailure(String error),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailure != null);
    return loadFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loadInitial(),
    TResult loadLoading(),
    TResult loadLoaded(MotorModel item),
    TResult loadFailure(String error),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadFailure != null) {
      return loadFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loadInitial(MotorInitial value),
    @required TResult loadLoading(MotorLoading value),
    @required TResult loadLoaded(MotorLoaded value),
    @required TResult loadFailure(MotorFailure value),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailure != null);
    return loadFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loadInitial(MotorInitial value),
    TResult loadLoading(MotorLoading value),
    TResult loadLoaded(MotorLoaded value),
    TResult loadFailure(MotorFailure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadFailure != null) {
      return loadFailure(this);
    }
    return orElse();
  }
}

abstract class MotorFailure implements MotorState {
  const factory MotorFailure(String error) = _$MotorFailure;

  String get error;
  @JsonKey(ignore: true)
  $MotorFailureCopyWith<MotorFailure> get copyWith;
}
