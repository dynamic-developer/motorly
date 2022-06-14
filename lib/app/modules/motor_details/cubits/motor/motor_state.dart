part of "motor_cubit.dart";

@freezed
abstract class MotorState with _$MotorState {
  const factory MotorState.loadInitial() = MotorInitial;
  const factory MotorState.loadLoading() = MotorLoading;
  const factory MotorState.loadLoaded(MotorModel item) = MotorLoaded;
  const factory MotorState.loadFailure(String error) = MotorFailure;
}
