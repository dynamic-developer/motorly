import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/repositories/database_repository.dart';
import '../../../home/models/new_offer_model.dart';

part 'recent_offers_state.dart';

class RecentOffersCubit extends Cubit<RecentOffersState> {
  final DatabaseRepository _service;
  RecentOffersCubit(this._service) : super(RecentOffersInitial());

  void load() async {
    emit(RecentOffersLoading());
    final result = await _service.fetchHistoryOffers();

    result.fold(
      (message) => emit(RecentOffersFailure(error: message)),
      (data) => emit(RecentOffersLoaded(data: data)),
    );
  }
}
