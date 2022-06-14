import 'package:flutter/material.dart';
import '../style/colors.dart';

class CustomFullscreenLoaderWidget extends StatelessWidget {
  const CustomFullscreenLoaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 5,
          ),
        ),
      ),
    );
  }
}
