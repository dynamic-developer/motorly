import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'shared/services/payment_service.dart';

class AppPurchase extends StatefulWidget {
  const AppPurchase({Key key, @required this.child}) : super(key: key);
  final Widget child;

  @override
  _AppPurchaseState createState() => _AppPurchaseState();
}

class _AppPurchaseState extends State<AppPurchase> {
  final iapService = Modular.get<InAppPurchaseService>();
  @override
  void initState() {
    super.initState();
    iapService.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    iapService.subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
