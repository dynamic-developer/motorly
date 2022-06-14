import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../home/models/models.dart';
import '../../repository/motors_repository.dart';

part 'motor_cubit.freezed.dart';
part 'motor_state.dart';

class MotorCubit extends Cubit<MotorState> {
  final MotorsRepository _repository;
  MotorCubit(this._repository) : super(MotorState.loadInitial());

  void load(String plate) async {
    emit(MotorState.loadLoading());
    final result = await _repository.fetchByPlate(plate);

    result.fold(
      (message) => emit(MotorState.loadFailure(message)),
      (item) => emit(MotorState.loadLoaded(item)),
    );
  }
}
