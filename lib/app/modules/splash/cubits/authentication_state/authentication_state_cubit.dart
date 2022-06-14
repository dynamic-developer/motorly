import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/repositories/user_repository.dart';

part 'authentication_state.dart';
part 'authentication_state_cubit.freezed.dart';

class AuthenticationStateCubit extends Cubit<AuthenticationState> {
  final UserRepository _repository;
  AuthenticationStateCubit(this._repository)
      : super(AuthenticationState.loadInitial());

  void verify() async {
    emit(AuthenticationState.loadLoading());
    final result = await _repository.getUser();
    result.fold(
      (user) => emit(AuthenticationState.loadUnauthenticated()),
      (failure) => emit(AuthenticationState.loadAuthenticated()),
    );
  }

  void checkFirstOpen(BuildContext context) async {
    var _prefs = await SharedPreferences.getInstance();
    var _isFirstOpen = _prefs.getBool('isFirstOpen') ?? true;
    if (_isFirstOpen) {
      Navigator.of(context).pushReplacementNamed("/tutorial");
    } else {
      Navigator.of(context).pushReplacementNamed("/home/");
    }
  }
}
