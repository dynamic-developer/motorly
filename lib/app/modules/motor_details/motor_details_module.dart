import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/services/firestore_service.dart';
import '../../shared/services/payment_service.dart';
import 'cubits/check_purchase/check_purchase_cubit.dart';
import 'cubits/motor/motor_cubit.dart';
import 'cubits/offers/offers_cubit.dart';
import 'cubits/purchase/purchase_cubit.dart';
import 'motor_details_page.dart';
import 'repository/motors_repository.dart';
import 'repository/purchase_repository.dart';

class MotorDetailsModule extends Module {
  static String get route => "/motor-details";
  @override
  List<Bind> get binds => [
        Bind((i) => MotorsRepository(i(), i())),
        Bind((i) => MotorCubit(i())),
        Bind((i) => OffersCubit(i())),
        Bind((i) => MotorlyticsReportRepository(i())),
        Bind((i) => PurchaseCubit(i.get<InAppPurchaseService>(),
            i.get<FirestoreService>(), i.get<MotorlyticsReportRepository>())),
        Bind((i) => CheckPurchaseCubit(i.get<FirestoreService>())),
      ];

  @override
  List<ChildRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => MotorDetailsPage(plate: args.data),
        ),
      ];
}
