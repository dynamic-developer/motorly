import 'package:flutter/material.dart';
import '../../../shared/style/text_styles.dart';

class ItemCardWidget extends StatelessWidget {
  final String title;
  final Function onTap;

  ItemCardWidget({
    this.onTap,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      // ignore: deprecated_member_use
      child: FlatButton(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.primaryBold.copyWith(
                fontSize: 12,
                color: Theme.of(context).canvasColor,
              ),
            ),
            Icon(
              Icons.arrow_right_alt,
              color: Theme.of(context).canvasColor,
            ),
          ],
        ),
      ),
    );
  }
}
