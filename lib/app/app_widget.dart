import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../flavors/flavor_config.dart';
import 'app_purchase.dart';
import 'shared/style/app_theme.dart';

class AppWidget extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return AppPurchase(
      child: MaterialApp(
        title: 'Motorly',
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        debugShowCheckedModeBanner: FlavorConfig.instance.isDevelopment,
        theme: AppTheme.dark,
      ).modular(),
    );

  }
}
