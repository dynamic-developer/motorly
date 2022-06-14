import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator.of(context).canPop()
        ? Container(
            height: 40,
            alignment: Alignment.topLeft,
            child: IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.keyboard_arrow_left,
                size: 33,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop(context);
              },
            ),
          )
        : Container();
  }
}
