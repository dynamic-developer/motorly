import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/repositories/user_repository.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.freezed.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final UserRepository _repository;
  SignUpCubit(this._repository) : super(SignUpState.loadInitial());

  void load({String email, String password, String name}) async {
    emit(SignUpState.loadLoading());
    final result = await _repository.signUp(
      email: email,
      password: password,
      username: name,
    );
    result.fold(
      (message) => emit(SignUpState.loadFailure(message)),
      (data) => emit(SignUpState.loadSuccess()),
    );
  }
}
