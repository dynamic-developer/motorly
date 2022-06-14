import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/services/firestore_service.dart';
import '../../../home/models/new_offer_model.dart';

part 'check_favorites_state.dart';

class CheckFavoritesCubit extends Cubit<CheckFavoritesState> {
  final FirestoreService _service;
  CheckFavoritesCubit(this._service) : super(CheckFavoritesInitial());

  Future<bool> load(NewOfferModel offer) async {
    emit(CheckFavoritesLoading());
    final result = await _service.checkFavorites(offer: offer);

    emit(CheckFavoritesLoaded(data: result));
    return result;
  }
}
