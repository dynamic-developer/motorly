import 'package:flutter/material.dart';
import '../style/app_dimensions.dart';
import '../style/colors.dart';
import '../style/text_styles.dart';

class CustomAppBarWidget extends StatelessWidget {
  final String title;
  final String description;
  CustomAppBarWidget({
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.maxFinite,
        padding: AppDimensions.marginScreen,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 13,
            ),
            if (Navigator.of(context).canPop())
              FloatingActionButton(
                backgroundColor: Theme.of(context).canvasColor == Colors.white
                    ? Color.fromRGBO(0, 0, 0, 0.20)
                    : Color.fromRGBO(255, 255, 255, 0.20),
                child: Icon(
                  Icons.keyboard_arrow_left,
                  size: 33,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
              ),
            if (title != null)
              SizedBox(
                width: 13,
              ),
            if (title != null)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(7.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.primaryH1Bold.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).canvasColor,
                          fontSize: 24,
                        ),
                      ),
                      if (description != null)
                        Text(
                          description,
                          style: AppTextStyles.primaryH1Bold.copyWith(
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).hoverColor,
                            fontSize: 20,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
