import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../shared/style/app_dimensions.dart';
import '../../../shared/style/text_styles.dart';

class ProfileWidget extends StatelessWidget {
  final String urlImage;
  final String fullName;

  ProfileWidget({
    this.fullName,
    this.urlImage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              image: urlImage != null
                  ? DecorationImage(
                      image: NetworkImage(urlImage),
                      fit: BoxFit.cover,
                    )
                  : null,
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 4.0,
              ),
            ),
            child: urlImage == null
                ? SvgPicture.asset("assets/ilustrations/user.svg")
                : null,
          ),
          AppDimensions.sizedSpace,
          Text(
            fullName,
            style: AppTextStyles.primaryBold.copyWith(
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          AppDimensions.sizedSpace,
          AppDimensions.sizedSpace,
        ],
      ),
    );
  }
}
