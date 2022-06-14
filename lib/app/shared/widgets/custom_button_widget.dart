import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../style/app_dimensions.dart';
import '../style/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool isLoading;
  final Color color;
  final Color textColor;
  final double buttonHeight;

  final double buttonWidth;
  final IconData iconData;
  final String svgIcon;
  final double svgIconSize;

  CustomButtonWidget({
    @required this.text,
    @required this.onTap,
    this.buttonHeight,
    this.color = AppColors.primary,
    this.isLoading = false,
    this.buttonWidth = double.infinity,
    this.iconData,
    this.textColor = Colors.white,
    this.svgIcon,
    this.svgIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth,
      height: buttonHeight ?? 50,
      // ignore: deprecated_member_use
      child: RaisedButton(
        disabledColor: isLoading ? color : AppColors.gray70,
        child: !isLoading
            ? _buildContent()
            : CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(textColor),
              ),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadius,
        ),
        elevation: 5,
        onPressed: !isLoading ? onTap : null,
      ),
    );
  }

  Widget _buildContent() {
    if (iconData != null || svgIcon != null) {
      return _buildWithIcon();
    }
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildWithIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (iconData != null)
          Icon(
            iconData,
            color: textColor,
          ),
        if (svgIcon != null)
          SvgPicture.asset(
            svgIcon,
            height: svgIconSize ?? 30,
          ),
        SizedBox(
          width: 13,
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
