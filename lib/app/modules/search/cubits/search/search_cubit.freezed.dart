// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SearchStateTearOff {
  const _$SearchStateTearOff();

// ignore: unused_element
  SearchInitial loadInitial() {
    return const SearchInitial();
  }

// ignore: unused_element
  SearchLoading loadLoading() {
    return const SearchLoading();
  }

// ignore: unused_element
  SearchLoaded loadLoaded(SearchResult item) {
    return SearchLoaded(
      item,
    );
  }

// ignore: unused_element
  SearchFailure loadFailure(String error) {
    return SearchFailure(
      error,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SearchState = _$SearchStateTearOff();

/// @nodoc
mixin _$SearchState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(SearchResult item),
    @required TResult loadFailure(String error),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult loadInitial(),
    TResult loadLoading(),
    TResult loadLoaded(SearchResult item),
    TResult loadFailure(String error),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult loadInitial(SearchInitial value),
    @required TResult loadLoading(SearchLoading value),
    @required TResult loadLoaded(SearchLoaded value),
    @required TResult loadFailure(SearchFailure value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult loadInitial(SearchInitial value),
    TResult loadLoading(SearchLoading value),
    TResult loadLoaded(SearchLoaded value),
    TResult loadFailure(SearchFailure value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res> implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  final SearchState _value;
  // ignore: unused_field
  final $Res Function(SearchState) _then;
}

/// @nodoc
abstract class $SearchInitialCopyWith<$Res> {
  factory $SearchInitialCopyWith(
          SearchInitial value, $Res Function(SearchInitial) then) =
      _$SearchInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchInitialCopyWithImpl<$Res> extends _$SearchStateCopyWithImpl<$Res>
    implements $SearchInitialCopyWith<$Res> {
  _$SearchInitialCopyWithImpl(
      SearchInitial _value, $Res Function(SearchInitial) _then)
      : super(_value, (v) => _then(v as SearchInitial));

  @override
  SearchInitial get _value => super._value as SearchInitial;
}

/// @nodoc
class _$SearchInitial implements SearchInitial {
  const _$SearchInitial();

  @override
  String toString() {
    return 'SearchState.loadInitial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is SearchInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(SearchResult item),
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
    TResult loadLoaded(SearchResult item),
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
    @required TResult loadInitial(SearchInitial value),
    @required TResult loadLoading(SearchLoading value),
    @required TResult loadLoaded(SearchLoaded value),
    @required TResult loadFailure(SearchFailure value),
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
    TResult loadInitial(SearchInitial value),
    TResult loadLoading(SearchLoading value),
    TResult loadLoaded(SearchLoaded value),
    TResult loadFailure(SearchFailure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadInitial != null) {
      return loadInitial(this);
    }
    return orElse();
  }
}

abstract class SearchInitial implements SearchState {
  const factory SearchInitial() = _$SearchInitial;
}

/// @nodoc
abstract class $SearchLoadingCopyWith<$Res> {
  factory $SearchLoadingCopyWith(
          SearchLoading value, $Res Function(SearchLoading) then) =
      _$SearchLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchLoadingCopyWithImpl<$Res> extends _$SearchStateCopyWithImpl<$Res>
    implements $SearchLoadingCopyWith<$Res> {
  _$SearchLoadingCopyWithImpl(
      SearchLoading _value, $Res Function(SearchLoading) _then)
      : super(_value, (v) => _then(v as SearchLoading));

  @override
  SearchLoading get _value => super._value as SearchLoading;
}

/// @nodoc
class _$SearchLoading implements SearchLoading {
  const _$SearchLoading();

  @override
  String toString() {
    return 'SearchState.loadLoading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is SearchLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(SearchResult item),
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
    TResult loadLoaded(SearchResult item),
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
    @required TResult loadInitial(SearchInitial value),
    @required TResult loadLoading(SearchLoading value),
    @required TResult loadLoaded(SearchLoaded value),
    @required TResult loadFailure(SearchFailure value),
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
    TResult loadInitial(SearchInitial value),
    TResult loadLoading(SearchLoading value),
    TResult loadLoaded(SearchLoaded value),
    TResult loadFailure(SearchFailure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadLoading != null) {
      return loadLoading(this);
    }
    return orElse();
  }
}

abstract class SearchLoading implements SearchState {
  const factory SearchLoading() = _$SearchLoading;
}

/// @nodoc
abstract class $SearchLoadedCopyWith<$Res> {
  factory $SearchLoadedCopyWith(
          SearchLoaded value, $Res Function(SearchLoaded) then) =
      _$SearchLoadedCopyWithImpl<$Res>;
  $Res call({SearchResult item});
}

/// @nodoc
class _$SearchLoadedCopyWithImpl<$Res> extends _$SearchStateCopyWithImpl<$Res>
    implements $SearchLoadedCopyWith<$Res> {
  _$SearchLoadedCopyWithImpl(
      SearchLoaded _value, $Res Function(SearchLoaded) _then)
      : super(_value, (v) => _then(v as SearchLoaded));

  @override
  SearchLoaded get _value => super._value as SearchLoaded;

  @override
  $Res call({
    Object item = freezed,
  }) {
    return _then(SearchLoaded(
      item == freezed ? _value.item : item as SearchResult,
    ));
  }
}

/// @nodoc
class _$SearchLoaded implements SearchLoaded {
  const _$SearchLoaded(this.item) : assert(item != null);

  @override
  final SearchResult item;

  @override
  String toString() {
    return 'SearchState.loadLoaded(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SearchLoaded &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(item);

  @JsonKey(ignore: true)
  @override
  $SearchLoadedCopyWith<SearchLoaded> get copyWith =>
      _$SearchLoadedCopyWithImpl<SearchLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(SearchResult item),
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
    TResult loadLoaded(SearchResult item),
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
    @required TResult loadInitial(SearchInitial value),
    @required TResult loadLoading(SearchLoading value),
    @required TResult loadLoaded(SearchLoaded value),
    @required TResult loadFailure(SearchFailure value),
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
    TResult loadInitial(SearchInitial value),
    TResult loadLoading(SearchLoading value),
    TResult loadLoaded(SearchLoaded value),
    TResult loadFailure(SearchFailure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadLoaded != null) {
      return loadLoaded(this);
    }
    return orElse();
  }
}

abstract class SearchLoaded implements SearchState {
  const factory SearchLoaded(SearchResult item) = _$SearchLoaded;

  SearchResult get item;
  @JsonKey(ignore: true)
  $SearchLoadedCopyWith<SearchLoaded> get copyWith;
}

/// @nodoc
abstract class $SearchFailureCopyWith<$Res> {
  factory $SearchFailureCopyWith(
          SearchFailure value, $Res Function(SearchFailure) then) =
      _$SearchFailureCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class _$SearchFailureCopyWithImpl<$Res> extends _$SearchStateCopyWithImpl<$Res>
    implements $SearchFailureCopyWith<$Res> {
  _$SearchFailureCopyWithImpl(
      SearchFailure _value, $Res Function(SearchFailure) _then)
      : super(_value, (v) => _then(v as SearchFailure));

  @override
  SearchFailure get _value => super._value as SearchFailure;

  @override
  $Res call({
    Object error = freezed,
  }) {
    return _then(SearchFailure(
      error == freezed ? _value.error : error as String,
    ));
  }
}

/// @nodoc
class _$SearchFailure implements SearchFailure {
  const _$SearchFailure(this.error) : assert(error != null);

  @override
  final String error;

  @override
  String toString() {
    return 'SearchState.loadFailure(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SearchFailure &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  $SearchFailureCopyWith<SearchFailure> get copyWith =>
      _$SearchFailureCopyWithImpl<SearchFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult loadInitial(),
    @required TResult loadLoading(),
    @required TResult loadLoaded(SearchResult item),
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
    TResult loadLoaded(SearchResult item),
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
    @required TResult loadInitial(SearchInitial value),
    @required TResult loadLoading(SearchLoading value),
    @required TResult loadLoaded(SearchLoaded value),
    @required TResult loadFailure(SearchFailure value),
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
    TResult loadInitial(SearchInitial value),
    TResult loadLoading(SearchLoading value),
    TResult loadLoaded(SearchLoaded value),
    TResult loadFailure(SearchFailure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadFailure != null) {
      return loadFailure(this);
    }
    return orElse();
  }
}

abstract class SearchFailure implements SearchState {
  const factory SearchFailure(String error) = _$SearchFailure;

  String get error;
  @JsonKey(ignore: true)
  $SearchFailureCopyWith<SearchFailure> get copyWith;
}
