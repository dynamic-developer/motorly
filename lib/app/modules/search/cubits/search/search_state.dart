part of 'search_cubit.dart';

@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState.loadInitial() = SearchInitial;
  const factory SearchState.loadLoading() = SearchLoading;
  const factory SearchState.loadLoaded(SearchResult item) = SearchLoaded;
  const factory SearchState.loadFailure(String error) = SearchFailure;
}
