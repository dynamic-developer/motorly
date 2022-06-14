import 'package:dio/dio.dart';

import '../../../flavors/flavor_config.dart';

// ignore: avoid_classes_with_only_static_members
class ApiClientFactory {
  static Dio create() {
    final dio = Dio();
    dio.options.baseUrl = FlavorConfig.instance.values.baseUrl;
    return dio;
  }
}
