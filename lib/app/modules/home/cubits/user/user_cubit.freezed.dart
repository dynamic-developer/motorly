// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'user_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$UserStateTearOff {
  const _$UserStateTearOff();

// ignore: unused_element
  Initial loadInitial() {
    return const Initial();
  }

// ignore: unused_element
  Loading loadLoading() {
    return const Loading();
  }

// ignore: unused_element
  Loaded loadLoaded(User user) {
    return Loaded(
      user,
    );
  }

// ignore: unused_element
  Failure loadFailre(String failure) {
    return Failure(
      failure,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $UserState = _$UserStateTearOff();

/// @nodoc
mixin _$UserState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(User user),
    @required TResult loadFailre(String failure),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loadInitial(),
    TResult loadLoading(),
    TResult loadLoaded(User user),
    TResult loadFailre(String failure),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loadInitial(Initial value),
    @required TResult loadLoading(Loading value),
    @required TResult loadLoaded(Loaded value),
    @required TResult loadFailre(Failure value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loadInitial(Initial value),
    TResult loadLoading(Loading value),
    TResult loadLoaded(Loaded value),
    TResult loadFailre(Failure value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $UserStateCopyWith<$Res> {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) =
      _$UserStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$UserStateCopyWithImpl<$Res> implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  final UserState _value;
  // ignore: unused_field
  final $Res Function(UserState) _then;
}

/// @nodoc
abstract class $InitialCopyWith<$Res> {
  factory $InitialCopyWith(Initial value, $Res Function(Initial) then) =
      _$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialCopyWithImpl<$Res> extends _$UserStateCopyWithImpl<$Res>
    implements $InitialCopyWith<$Res> {
  _$InitialCopyWithImpl(Initial _value, $Res Function(Initial) _then)
      : super(_value, (v) => _then(v as Initial));

  @override
  Initial get _value => super._value as Initial;
}

/// @nodoc
class _$Initial implements Initial {
  const _$Initial();

  @override
  String toString() {
    return 'UserState.loadInitial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(User user),
    @required TResult loadFailre(String failure),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailre != null);
    return loadInitial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loadInitial(),
    TResult loadLoading(),
    TResult loadLoaded(User user),
    TResult loadFailre(String failure),
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
    @required TResult loadInitial(Initial value),
    @required TResult loadLoading(Loading value),
    @required TResult loadLoaded(Loaded value),
    @required TResult loadFailre(Failure value),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailre != null);
    return loadInitial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loadInitial(Initial value),
    TResult loadLoading(Loading value),
    TResult loadLoaded(Loaded value),
    TResult loadFailre(Failure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadInitial != null) {
      return loadInitial(this);
    }
    return orElse();
  }
}

abstract class Initial implements UserState {
  const factory Initial() = _$Initial;
}

/// @nodoc
abstract class $LoadingCopyWith<$Res> {
  factory $LoadingCopyWith(Loading value, $Res Function(Loading) then) =
      _$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoadingCopyWithImpl<$Res> extends _$UserStateCopyWithImpl<$Res>
    implements $LoadingCopyWith<$Res> {
  _$LoadingCopyWithImpl(Loading _value, $Res Function(Loading) _then)
      : super(_value, (v) => _then(v as Loading));

  @override
  Loading get _value => super._value as Loading;
}

/// @nodoc
class _$Loading implements Loading {
  const _$Loading();

  @override
  String toString() {
    return 'UserState.loadLoading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(User user),
    @required TResult loadFailre(String failure),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailre != null);
    return loadLoading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loadInitial(),
    TResult loadLoading(),
    TResult loadLoaded(User user),
    TResult loadFailre(String failure),
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
    @required TResult loadInitial(Initial value),
    @required TResult loadLoading(Loading value),
    @required TResult loadLoaded(Loaded value),
    @required TResult loadFailre(Failure value),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailre != null);
    return loadLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loadInitial(Initial value),
    TResult loadLoading(Loading value),
    TResult loadLoaded(Loaded value),
    TResult loadFailre(Failure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadLoading != null) {
      return loadLoading(this);
    }
    return orElse();
  }
}

abstract class Loading implements UserState {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class $LoadedCopyWith<$Res> {
  factory $LoadedCopyWith(Loaded value, $Res Function(Loaded) then) =
      _$LoadedCopyWithImpl<$Res>;
  $Res call({User user});
}

/// @nodoc
class _$LoadedCopyWithImpl<$Res> extends _$UserStateCopyWithImpl<$Res>
    implements $LoadedCopyWith<$Res> {
  _$LoadedCopyWithImpl(Loaded _value, $Res Function(Loaded) _then)
      : super(_value, (v) => _then(v as Loaded));

  @override
  Loaded get _value => super._value as Loaded;

  @override
  $Res call({
    Object user = freezed,
  }) {
    return _then(Loaded(
      user == freezed ? _value.user : user as User,
    ));
  }
}

/// @nodoc
class _$Loaded implements Loaded {
  const _$Loaded(this.user) : assert(user != null);

  @override
  final User user;

  @override
  String toString() {
    return 'UserState.loadLoaded(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Loaded &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(user);

  @JsonKey(ignore: true)
  @override
  $LoadedCopyWith<Loaded> get copyWith =>
      _$LoadedCopyWithImpl<Loaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(User user),
    @required TResult loadFailre(String failure),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailre != null);
    return loadLoaded(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loadInitial(),
    TResult loadLoading(),
    TResult loadLoaded(User user),
    TResult loadFailre(String failure),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadLoaded != null) {
      return loadLoaded(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loadInitial(Initial value),
    @required TResult loadLoading(Loading value),
    @required TResult loadLoaded(Loaded value),
    @required TResult loadFailre(Failure value),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailre != null);
    return loadLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loadInitial(Initial value),
    TResult loadLoading(Loading value),
    TResult loadLoaded(Loaded value),
    TResult loadFailre(Failure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadLoaded != null) {
      return loadLoaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements UserState {
  const factory Loaded(User user) = _$Loaded;

  User get user;
  @JsonKey(ignore: true)
  $LoadedCopyWith<Loaded> get copyWith;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res>;
  $Res call({String failure});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res> extends _$UserStateCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(Failure _value, $Res Function(Failure) _then)
      : super(_value, (v) => _then(v as Failure));

  @override
  Failure get _value => super._value as Failure;

  @override
  $Res call({
    Object failure = freezed,
  }) {
    return _then(Failure(
      failure == freezed ? _value.failure : failure as String,
    ));
  }
}

/// @nodoc
class _$Failure implements Failure {
  const _$Failure(this.failure) : assert(failure != null);

  @override
  final String failure;

  @override
  String toString() {
    return 'UserState.loadFailre(failure: $failure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Failure &&
            (identical(other.failure, failure) ||
                const DeepCollectionEquality().equals(other.failure, failure)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(failure);

  @JsonKey(ignore: true)
  @override
  $FailureCopyWith<Failure> get copyWith =>
      _$FailureCopyWithImpl<Failure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(User user),
    @required TResult loadFailre(String failure),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailre != null);
    return loadFailre(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loadInitial(),
    TResult loadLoading(),
    TResult loadLoaded(User user),
    TResult loadFailre(String failure),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadFailre != null) {
      return loadFailre(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loadInitial(Initial value),
    @required TResult loadLoading(Loading value),
    @required TResult loadLoaded(Loaded value),
    @required TResult loadFailre(Failure value),
  }) {
    assert(loadInitial != null);
    assert(loadLoading != null);
    assert(loadLoaded != null);
    assert(loadFailre != null);
    return loadFailre(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loadInitial(Initial value),
    TResult loadLoading(Loading value),
    TResult loadLoaded(Loaded value),
    TResult loadFailre(Failure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadFailre != null) {
      return loadFailre(this);
    }
    return orElse();
  }
}

abstract class Failure implements UserState {
  const factory Failure(String failure) = _$Failure;

  String get failure;
  @JsonKey(ignore: true)
  $FailureCopyWith<Failure> get copyWith;
}
