import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/style/app_dimensions.dart';
import '../../../../shared/style/text_styles.dart';

class FinishResetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppDimensions.marginScreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Theme.of(context).canvasColor == Colors.white
                  ? 'assets/ilustrations/email-dark.svg'
                  : 'assets/ilustrations/email-white.svg',
              height: 200,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Check your Email",
              style: AppTextStyles.primaryH1Bold.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).canvasColor,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "We have sent you a reset password link on your "
              "registered email address",
              textAlign: TextAlign.center,
              style: AppTextStyles.primaryH1Bold.copyWith(
                fontWeight: FontWeight.w300,
                color: Theme.of(context).hoverColor,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
