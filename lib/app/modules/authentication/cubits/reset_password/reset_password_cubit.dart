import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/repositories/user_repository.dart';

part 'reset_password_state.dart';
part 'reset_password_cubit.freezed.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final UserRepository _repository;
  ResetPasswordCubit(this._repository)
      : super(ResetPasswordState.loadInitial());

  void load({String email}) async {
    emit(ResetPasswordState.loadLoading());
    final result = await _repository.resetPassword(email);
    result.fold(
      (message) => emit(ResetPasswordState.loadFailure(message)),
      (data) => emit(ResetPasswordState.loadSuccess()),
    );
  }
}
