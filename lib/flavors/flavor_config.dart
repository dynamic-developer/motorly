import 'package:flutter/material.dart';

import 'flavor_values.dart';

enum Flavors {
  // ignore: constant_identifier_names
  DEV,
  // ignore: constant_identifier_names
  PROD,
}

class FlavorConfig {
  final Flavors flavor;
  final FlavorValues values;
  static FlavorConfig _instance;

  factory FlavorConfig({
    @required Flavors flavor,
    @required FlavorValues values,
  }) =>
      _instance ??= FlavorConfig._internal(flavor, values);

  FlavorConfig._internal(this.flavor, this.values);

  static FlavorConfig get instance => _instance;

  bool get isProduction => _instance?.flavor == Flavors.PROD;
  bool get isDevelopment => _instance?.flavor == Flavors.DEV;
}
