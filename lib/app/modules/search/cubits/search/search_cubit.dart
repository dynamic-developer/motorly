import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../home/models/filter_model.dart';

import '../../repository/search_repository.dart';

part 'search_cubit.freezed.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _repository;
  SearchCubit(this._repository) : super(SearchState.loadInitial());

  void load(FilterOfferModel filter) async {
    emit(SearchState.loadLoading());
    final result = await _repository.searchOffers(filter);

    result.fold(
      (message) => emit(SearchState.loadFailure(message)),
      (item) => emit(SearchState.loadLoaded(item)),
    );
  }
}
