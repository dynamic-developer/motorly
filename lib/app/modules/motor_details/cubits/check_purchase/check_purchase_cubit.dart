import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../shared/services/firestore_service.dart';

part 'check_purchase_state.dart';

class CheckPurchaseCubit extends Cubit<CheckPurchaseState> {
  final FirestoreService _service;
  CheckPurchaseCubit(this._service) : super(CheckPurchaseInitial());

  void load(String reportId) async {
    final _authInstance = FirebaseAuth.instance;
    var _user = await _authInstance.currentUser;
    emit(CheckPurchaseLoading());
    var result;
    if (_user != null) {
      result = await _service.checkPurchase(reportId: reportId);
    } else {
      result = false;
    }
    emit(result ? CheckPurchased() : CheckNoPurchase());
  }
}
