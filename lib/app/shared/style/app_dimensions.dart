import 'package:flutter/material.dart';

mixin AppDimensions {
  static final borderRadius = BorderRadius.circular(5);
  static final marginHorizontal = EdgeInsets.symmetric(horizontal: 20);
  static final marginScreen = EdgeInsets.all(20);
  static final marginWidget = EdgeInsets.all(13);
  static final detailsMarginWidget = EdgeInsets.all(18);

  static final space = 20.0;

  static final sizedSpace = SizedBox(height: AppDimensions.space);
}
