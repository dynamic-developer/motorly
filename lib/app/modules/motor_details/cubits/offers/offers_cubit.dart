import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../home/models/filter_model.dart';
import '../../repository/motors_repository.dart';

part 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final MotorsRepository motorsRepository;
  OffersCubit(this.motorsRepository) : super(OffersInitial());

  void load(FilterOfferModel filter) async {
    emit(OffersLoading());
    final result = await motorsRepository.fetchOffers(filter);

    result.fold((message) => emit(OffersFailure(error: message)), (data) async {
      emit(OffersLoaded(data: data));

      final preferences = await SharedPreferences.getInstance();

      final count = preferences.getInt("open-offer") ?? 0;

      await preferences.setInt("open-offer", count + 1);

      final count2 = preferences.getInt("open-offer");

      final inAppReview = InAppReview.instance;

      if (await inAppReview.isAvailable() && count2 % 3 == 0) {
        inAppReview.requestReview();
      }
    });
  }
}
