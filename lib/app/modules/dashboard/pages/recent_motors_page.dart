import 'package:flutter/material.dart';

import '../../favorites/widgets/item_motor_favorite_widget.dart';
import '../../home/models/models.dart';
import '../../motor_details/widgets/app_bar_widget.dart';

class RecentMotorsPage extends StatefulWidget {
  final List<MotorModel> data;

  RecentMotorsPage(this.data);
  @override
  _MotorsFavoritePageState createState() => _MotorsFavoritePageState();
}

class _MotorsFavoritePageState extends State<RecentMotorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            AppBarWidget(),
            SizedBox(width: 13),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.data.length,
              itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: 27.0,
                    right: 13,
                    left: 13,
                  ),
                  child: ItemMotorFavoriteWidget(motor: widget.data[index])),
            ),
          ]),
        ),
      ),
    );
  }
}
