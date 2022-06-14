part of 'sign_up_cubit.dart';

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState.loadInitial() = Initial;
  const factory SignUpState.loadLoading() = Loading;
  const factory SignUpState.loadSuccess() = Success;
  const factory SignUpState.loadFailure(String message) = Failure;
}
