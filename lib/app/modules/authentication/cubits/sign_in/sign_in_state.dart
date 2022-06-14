part of 'sign_in_cubit.dart';

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState.loadInitial() = Initial;
  const factory SignInState.loadLoading() = Loading;
  const factory SignInState.loadSuccess() = Success;
  const factory SignInState.loadFailure(String message) = Failure;
}
