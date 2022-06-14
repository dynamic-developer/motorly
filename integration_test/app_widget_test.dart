import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:motorly/app/app_widget.dart';
import 'package:motorly/app/modules/home/home_page.dart';
import 'package:motorly/app/modules/home/pages/market_page.dart';
//import 'package:motorly/app/modules/home/pages/motor_details/motor_details_page.dart';
import 'package:motorly/app/modules/lessons/lessons_page.dart';

import 'app_module_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets(
    "load app and test login page with valid arguments, (user have permissions)",
    (tester) async {
      await tester.pumpWidget(ModularApp(
        module: AppModuleTest(),
        child: AppWidget(),
      ));

      await tester.pumpAndSettle();

      await tester.pumpAndSettle();

      expect(find.byType(TutorialPage), findsOneWidget);

      await tester.tap(find.text("Let\'s start!"));

      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);

      await tester.tap(find.byKey(Key("Scan")));

      await tester.pumpAndSettle();

      expect(find.byType(MarketPage), findsOneWidget);

      await tester.enterText(
        find.byType(TextFormField),
        "LGK95",
      );

      await tester.tap(find.text("GO"));

      await tester.pumpAndSettle();

      // expect(find.byType(MotorDetailsPage), findsOneWidget);
    },
  );
}
