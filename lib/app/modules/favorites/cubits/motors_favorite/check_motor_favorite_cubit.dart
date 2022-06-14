import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../shared/services/firestore_service.dart';
import '../../../home/models/old_motor_model.dart';

part 'check_motor_favorites_state.dart';

class CheckMotorFavoritesCubit extends Cubit<CheckMotorFavoritesState> {
  final FirestoreService _service;
  CheckMotorFavoritesCubit(this._service) : super(CheckMotorFavoritesInitial());

  void load(MotorModel motor) async {
    final _authInstance = FirebaseAuth.instance;
    var _user = await _authInstance.currentUser;
    emit(CheckMotorFavoritesLoading());
    var result;
    if (_user != null) {
      result = await _service.checkFavoritesMotor(motor: motor);
    } else {
      result = false;
    }
    emit(result ? CheckMotorFavorite() : CheckMotorNoFavorite());
  }
}
