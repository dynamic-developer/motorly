import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/repositories/user_repository.dart';

part 'sign_in_state.dart';
part 'sign_in_cubit.freezed.dart';

class SignInCubit extends Cubit<SignInState> {
  final UserRepository _repository;
  SignInCubit(this._repository) : super(SignInState.loadInitial());

  void load({String email, String password}) async {
    emit(SignInState.loadLoading());
    final result = await _repository.signInWithCredentials(
      email: email,
      password: password,
    );
    result.fold(
      (message) => emit(SignInState.loadFailure(message)),
      (data) => emit(SignInState.loadSuccess()),
    );
  }

  void loadWithGoogle() async {
    emit(SignInState.loadLoading());
    final result = await _repository.signInWithGoogle();
    result.fold(
      (message) => emit(SignInState.loadFailure(message)),
      (data) => emit(SignInState.loadSuccess()),
    );
  }

  void loadWithFacebook() async {
    emit(SignInState.loadLoading());
    final result = await _repository.signInWithFacebook();
    result.fold(
      (message) => emit(SignInState.loadFailure(message)),
      (data) => emit(SignInState.loadSuccess()),
    );
  }

  void loadWithApple() async {
    emit(SignInState.loadLoading());
    final result = await _repository.signInWithApple();
    result.fold(
      (message) => emit(SignInState.loadFailure(message)),
      (data) => emit(SignInState.loadSuccess()),
    );
  }
}
