import 'package:flutter/material.dart';

import '../../modules/home/models/filter_model.dart';

class StoryItem {
  final String label;
  final FilterOfferModel filter;
  final String assetImage;

  StoryItem({@required this.label, @required this.filter, this.assetImage});
}
