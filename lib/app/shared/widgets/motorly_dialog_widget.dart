import 'package:flutter/material.dart';

import '../style/colors.dart';
import 'custom_button_widget.dart';

class MotorlyDialogWidget extends StatelessWidget {
  MotorlyDialogWidget({
    Key key,
    this.action,
    this.buttonTitle,
    this.description,
    this.title,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final String description;
  final Function action;
  final String buttonTitle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(14.0),
        ),
      ),
      backgroundColor: AppColors.backgroundCard,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Open Sans",
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffe1e1e6),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 30),
          CustomButtonWidget(
            text: buttonTitle,
            isLoading: isLoading,
            onTap: action,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
