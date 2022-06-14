import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/style/text_styles.dart';
import '../../../shared/widgets/custom_button_widget.dart';

class NoOffersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 42,
        ),
        Center(
          child: Text(
            'Ooops...',
            style: AppTextStyles.primaryMotorDetailBold.copyWith(
              color: Theme.of(context).canvasColor,
            ),
          ),
        ),
        SizedBox(
          height: 26,
        ),
        Container(
          margin: EdgeInsets.all(13),
          child: Text(
            'We couldn\'t find any offers, let\'s try again? :)',
            style: AppTextStyles.primaryBoldDescription.copyWith(
              color: Theme.of(context).canvasColor,
            ),
          ),
        ),
        SizedBox(
          height: 33,
        ),
        Center(
          child: SvgPicture.asset(
            'assets/icon/car.svg',
            height: 42,
          ),
        ),
        SizedBox(
          height: 42,
        ),
        CustomButtonWidget(
            text: "Back to home",
            onTap: () {
              Navigator.of(context).maybePop();
            }),
      ],
    );
  }
}
