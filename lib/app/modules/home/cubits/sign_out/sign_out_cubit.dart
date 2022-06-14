import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/repositories/user_repository.dart';

part 'sign_out_state.dart';
part 'sign_out_cubit.freezed.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final UserRepository _repository;
  SignOutCubit(this._repository) : super(SignOutState.loadInitial());

  void load() async {
    emit(SignOutState.loadLoading());
    final result = await _repository.signOut();
    result.fold(
      (message) => emit(SignOutState.loadFailure(message)),
      (data) => emit(SignOutState.loadSuccess()),
    );
  }
}
