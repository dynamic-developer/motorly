import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/services/firestore_service.dart';
import '../../../home/models/old_motor_model.dart';

part 'motor_favorites_state.dart';

class MotorsFavoritesCubit extends Cubit<MotorsFavoritesState> {
  final FirestoreService _service;
  MotorsFavoritesCubit(this._service) : super(MotorsFavoritesInitial());

  void load() async {
    emit(MotorsFavoritesLoading());
    final result = await _service.getFavoritesMotors();

    result.fold(
      (message) => emit(MotorsFavoritesFailure(error: message)),
      (data) => emit(MotorsFavoritesLoaded(data: data)),
    );
  }
}
