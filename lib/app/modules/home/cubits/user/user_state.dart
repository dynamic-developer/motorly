part of 'user_cubit.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState.loadInitial() = Initial;
  const factory UserState.loadLoading() = Loading;
  const factory UserState.loadLoaded(User user) = Loaded;
  const factory UserState.loadFailre(String failure) = Failure;
}
