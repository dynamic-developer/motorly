import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/colors.dart';

class LoginButtonWidget extends StatelessWidget {
  final Function onTap;
  final bool isLoading;
  final Color color;
  final Color textColor;
  final String text;
  final String svgIcon;

  LoginButtonWidget({
    @required this.onTap,
    this.color = AppColors.primary,
    this.isLoading = false,
    this.textColor = Colors.white,
    this.text,
    @required this.svgIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      // ignore: deprecated_member_use
      child: RaisedButton(
        disabledColor: isLoading ? color : AppColors.gray70,
        child: !isLoading
            ? Row(
                children: [
                  _buildIcon(),
                  Spacer(),
                  Text(text,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: "OpenSans",
                      )),
                  Spacer(),
                ],
              )
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

  Widget _buildIcon() {
    return Center(
      child: SvgPicture.asset(
        svgIcon,
        height: 33,
        width: 33,
      ),
    );
  }
}
