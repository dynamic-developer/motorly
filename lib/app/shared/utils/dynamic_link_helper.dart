import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/shared/utils/analytics_helper.dart';
import '../../modules/motor_details/motor_details_module.dart';

import '../models/dynamic_link_model.dart';
import '../services/firestore_service.dart';

class DynamicLinkHelper {
  static final DynamicLinkHelper appDynamicLinkHelper = DynamicLinkHelper();
  ValueNotifier<DynamicLinkModel> loaderShowingNotifier =
      ValueNotifier(DynamicLinkModel(offer: 'null', plate: 'null'));

  // ignore: use_setters_to_change_properties
  void showDynamicLinkHelper(DynamicLinkModel object) {
    loaderShowingNotifier.value = object;
    _handleLink(object);
  }

  Future<void> _handleLink(DynamicLinkModel value) async {
    if (value.plate != 'null') {
      AnalyticsHelper.viewSharedModel();
      Modular.to.pushNamed(MotorDetailsModule.route, arguments: value.plate);
    } else if (value.offer != 'null') {
      var _offerId = value.offer;
      final _firestoreService = Modular.get<FirestoreService>();

      var _offer = await _firestoreService.getDynamicLinkObject(id: _offerId);

      AnalyticsHelper.viewSharedOffer();

      Modular.to.pushNamed(
        "/offers/details",
        arguments: _offer,
      );
    }
  }
}
