import 'package:flutter/material.dart';
import '../style/app_dimensions.dart';
import '../style/text_styles.dart';

class CustomOutlinedButtonWidget extends StatelessWidget {
  final Function onTap;
  final String title;

  CustomOutlinedButtonWidget({@required this.onTap, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      // ignore: deprecated_member_use
      child: OutlineButton(
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadius,
        ),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
        onPressed: onTap,
        child: Text(
          "$title",
          style: AppTextStyles.primaryBold.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
