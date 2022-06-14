import 'package:flutter/material.dart';
import '../style/app_dimensions.dart';
import '../style/colors.dart';
import 'custom_button_widget.dart';

class PermissionRequiredWidget extends StatelessWidget {
  final BuildContext currentContext;
  PermissionRequiredWidget({
    this.currentContext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: AppDimensions.borderRadius,
        color: AppColors.backgroundCard.withOpacity(0.4),
      ),
      padding: AppDimensions.marginScreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You need to log in to view this page :)",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            child: CustomButtonWidget(
              text: "Login or Register",
              onTap: () {
                Navigator.of(context).pushNamed("/authentication");
              },
            ),
          ),
        ],
      ),
    );
  }
}
