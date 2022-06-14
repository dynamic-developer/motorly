import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import '../../../../shared/models/motor_report_model.dart';
import '../../../../shared/services/firestore_service.dart';
import '../../../../shared/services/payment_service.dart';
import '../../../home/models/models.dart';
import '../../repository/purchase_repository.dart';

part 'purchase_state.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  final InAppPurchaseService purchaseService;
  final FirestoreService firestoreService;
  final MotorlyticsReportRepository purchaseRepository;
  PurchaseCubit(
      this.purchaseService, this.firestoreService, this.purchaseRepository)
      : super(PurchaseInitial());

  void finishBuy(MotorModel motor) async {
    emit(PurchaseLoadingBuy());

    var report = MotorReportModel();
    report.plateNumber = motor.plate;
    report.make = motor.make;
    report.model = motor.model;
    report.year = motor.year;
    report.subModel = motor.subModel;
    report.purchaseId = purchaseService.purchase?.purchaseID;
    report.userId = purchaseService.purchase?.purchaseID;
    report.paymentMethod = Platform.isIOS ? "applePay" : "googlePay";

    final result = await firestoreService.addReportPurchase(report: report);

    await result.fold(
      (l) {
        emit(PurchaseFailure(error: l));
      },
      (r) async {
        final motorlyticsResult =
            await purchaseRepository.getMotorlyticsReport(r);

        await motorlyticsResult.fold((l) {
          //TODO: Refund InApp Purchase?,
          //delete purchase on database
          emit(PurchaseFailure(error: l));
        }, (r) {
          emit(PurchaseSuccess(r));
        });
      },
    );
  }

  void listener({@required MotorModel motor}) async {
    if (purchaseService.isPurchased) {
      if (purchaseService.purchase == null) {
        emit(PurchaseFailure(error: ""));
      } else {
        if (state is PurchaseLoading) {
          finishBuy(motor);
          return;
        }
      }
      purchaseService.removeListener(() => listener(motor: motor));
    }
  }

  void buy({@required MotorModel motor}) async {
    emit(PurchaseLoading());
    final result = await purchaseService.buyProduct();
    if (result) {
      purchaseService.addListener(() => listener(motor: motor));
    } else {
      emit(PurchaseFailure(error: ""));
    }
  }
}
