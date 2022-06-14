import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/shared/instances/allow_buy_instance.dart';
import 'app/shared/services/remote_config_service.dart';

void allowBuy() async {
  final result = await RemoteConfigService().allowBuy();
  AllowBuyInstance(allowed: result);
}

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (defaultTargetPlatform == TargetPlatform.android) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }
  if (kIsWeb) {
    runApp(ModularApp(
      module: AppModule(),
      child: AppWidget(),
    ));
  } else {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    allowBuy();
    runZonedGuarded(
      () => runApp(ModularApp(
        module: AppModule(),
        child: AppWidget(),
      )),
      FirebaseCrashlytics.instance.recordError,
    );
  }



}
