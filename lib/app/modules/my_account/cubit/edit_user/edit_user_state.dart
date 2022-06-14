part of 'edit_user_cubit.dart';

@freezed
abstract class EditUserState with _$EditUserState {
  const factory EditUserState.loadInitial() = Initial;
  const factory EditUserState.loadLoading() = Loading;
  const factory EditUserState.loadUpdated() = Updated;
  const factory EditUserState.loadFailure(String failure) = Failure;
}
