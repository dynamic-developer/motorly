part of 'authentication_state_cubit.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.loadInitial() = Initial;
  const factory AuthenticationState.loadLoading() = Loading;
  const factory AuthenticationState.loadAuthenticated() = Authenticated;
  const factory AuthenticationState.loadUnauthenticated() = Unauthenticated;
}
