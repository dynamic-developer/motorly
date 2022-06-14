import 'package:flutter/material.dart';

class ShimmerOffersWidget extends StatelessWidget {
  const ShimmerOffersWidget({
    Key key,
    this.height,
  }) : super(key: key);

  final double height;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(20),
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
          height: height ?? 300,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).cardColor,
          ),
        ),
      ),
      itemCount: 6,
    );
  }
}
