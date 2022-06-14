import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/repositories/user_repository.dart';

part 'edit_user_state.dart';
part 'edit_user_cubit.freezed.dart';

class EditUserCubit extends Cubit<EditUserState> {
  final UserRepository _repository;
  EditUserCubit(this._repository) : super(EditUserState.loadInitial());

  void edit({String username, String email}) async {
    emit(EditUserState.loadLoading());
    final result = await _repository.updateUser(
      email: email,
      username: username,
    );
    result.fold(
      (failure) => emit(EditUserState.loadFailure(failure)),
      (user) => emit(EditUserState.loadUpdated()),
    );
  }
}
