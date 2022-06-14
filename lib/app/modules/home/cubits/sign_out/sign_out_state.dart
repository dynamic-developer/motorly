part of 'sign_out_cubit.dart';

@freezed
abstract class SignOutState with _$SignOutState {
  const factory SignOutState.loadInitial() = Initial;
  const factory SignOutState.loadLoading() = Loading;
  const factory SignOutState.loadSuccess() = Success;
  const factory SignOutState.loadFailure(String message) = Failure;
}
