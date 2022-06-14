import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/services/firestore_service.dart';
import '../../../home/models/new_offer_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FirestoreService _service;
  FavoritesCubit(this._service) : super(FavoritesInitial());

  void load() async {
    emit(FavoritesLoading());
    final result = await _service.getFavorites();

    result.fold(
      (message) => emit(FavoritesFailure(error: message)),
      (data) => emit(FavoritesLoaded(data: data)),
    );
  }
}
