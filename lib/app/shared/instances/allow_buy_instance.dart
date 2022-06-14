import 'package:flutter/material.dart';

class AllowBuyInstance {
  final bool allowed;

  static AllowBuyInstance _instance;

  factory AllowBuyInstance({@required bool allowed}) {
    return _instance ??= AllowBuyInstance._internal(allowed);
  }

  AllowBuyInstance._internal(this.allowed);

  static AllowBuyInstance get instance => _instance;
}
