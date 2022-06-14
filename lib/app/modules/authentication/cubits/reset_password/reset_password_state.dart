part of 'reset_password_cubit.dart';

@freezed
abstract class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.loadInitial() = Initial;
  const factory ResetPasswordState.loadLoading() = Loading;
  const factory ResetPasswordState.loadSuccess() = Success;
  const factory ResetPasswordState.loadFailure(String message) = Failure;
}
