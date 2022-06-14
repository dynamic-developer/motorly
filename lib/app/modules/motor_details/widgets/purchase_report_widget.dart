import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/widgets/motorly_dialog_widget.dart';
import '../../home/models/models.dart';
import '../cubits/check_purchase/check_purchase_cubit.dart';
import '../cubits/purchase/purchase_cubit.dart';

class PurchaseReportWidget extends StatelessWidget {
  PurchaseReportWidget({Key key, @required this.motor}) : super(key: key);
  final purchaseCubit = Modular.get<PurchaseCubit>();
  final checkPurchased = Modular.get<CheckPurchaseCubit>();

  final MotorModel motor;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchaseCubit, PurchaseState>(
      bloc: purchaseCubit,
      listener: (context, state) {
        if (state is PurchaseSuccess) {
          Navigator.pop(context);
          //checkPurchased.load(motor);
          showDialog(
            context: context,
            builder: (_) => MotorlyDialogWidget(
              title: "Congratulations",
              description:
                  "You have purchased the report. View all Property History, Hidden Issues, and more.",
              action: () => launch(state.link),
              buttonTitle: 'View Report',
            ),
          );
        }

        if (state is PurchaseFailure) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (_) => MotorlyDialogWidget(
              title: "Sorry",
              description: "We can't complete you purchase, try again later.",
              action: () => Navigator.pop(context),
              buttonTitle: 'Back',
            ),
          );
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/lemon.png',
              scale: 0.8,
            ),
            SizedBox(width: 3),
            RichText(
                text: TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                    context: context,
                    builder: (_) => MotorlyDialogWidget(
                      title: "Get Motorly Report",
                      isLoading: state is PurchaseLoading ||
                          state is PurchaseLoadingBuy,
                      description:
                          "More than 50 checks to find problems. Property history, hidden issues, and more.",
                      action: () => purchaseCubit.buy(motor: motor),
                      buttonTitle: 'Get',
                    ),
                  );
                },
              text: 'Is this a lemon?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[400],
              ),
            )),
          ],
        );
      },
    );
  }
}
