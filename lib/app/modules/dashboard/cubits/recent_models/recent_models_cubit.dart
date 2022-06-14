import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/repositories/database_repository.dart';
import '../../../home/models/models.dart';

part 'recent_models_state.dart';

class RecentModelsCubit extends Cubit<RecentModelsState> {
  final DatabaseRepository _service;
  RecentModelsCubit(this._service) : super(RecentModelsInitial());

  void load() async {
    emit(RecentModelsLoading());
    final result = await _service.fetchHistoryModels();

    result.fold(
      (message) => emit(RecentModelsFailure(error: message)),
      (data) => emit(RecentModelsLoaded(data: data)),
    );
  }
}
