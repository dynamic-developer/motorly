import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/shared/style/app_theme.dart';
import 'package:motorly/flavors/dev_values.dart';
import 'package:motorly/flavors/flavor_config.dart';

class AppWidgetTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlavorConfig(flavor: Flavors.DEV, values: DevValues());

    return MaterialApp(
      title: 'Motorly',
      navigatorObservers: [],
      debugShowCheckedModeBanner: FlavorConfig.instance.isDevelopment,
      theme: AppTheme.dark,
      initialRoute: Modular.initialRoute,
    );
  }
}
