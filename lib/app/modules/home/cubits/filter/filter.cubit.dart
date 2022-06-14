import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motorly/app/modules/home/models/filter_model.dart';

class FilterCubit extends Cubit<FilterOfferModel> {
  FilterCubit() : super(FilterOfferModel(page: 1, pageSize: 10, keywords: ""));

  void updateIndex(FilterOfferModel filter) {
    emit(filter);
  }
}
