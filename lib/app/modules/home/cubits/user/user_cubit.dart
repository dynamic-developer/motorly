import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/repositories/user_repository.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _repository;
  UserCubit(this._repository) : super(UserState.loadInitial());

  void load() async {
    emit(UserState.loadLoading());
    final result = await _repository.getUser();
    result.fold(
      (failure) => emit(UserState.loadFailre(failure)),
      (user) => emit(UserState.loadLoaded(user)),
    );
  }
}
