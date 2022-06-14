import 'package:flutter/material.dart';
import '../../../shared/style/text_styles.dart';
import '../../../shared/widgets/custom_button_widget.dart';

class FailureWidget extends StatelessWidget {
  final String message;
  FailureWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.33),
          Text(
            "$message",
            textAlign: TextAlign.center,
            style: AppTextStyles.primaryH1Medium,
          ),
          SizedBox(height: 20),
          CustomButtonWidget(
            buttonWidth: 100,
            text: "Back",
            onTap: () {
              Navigator.of(context).pop(context);
            },
          ),
        ],
      ),
    );
  }
}
