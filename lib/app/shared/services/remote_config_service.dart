import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  Future<RemoteConfig> _getRemoteConfig() async {
    final remoteConfig = await RemoteConfig.instance;
    final defaults = <String, dynamic>{'welcome': 'default welcome'};

    await remoteConfig.setDefaults(defaults);

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 5),
      minimumFetchInterval: Duration.zero,
    ));
    await remoteConfig.fetchAndActivate();
    return remoteConfig;
  }

  Future<String> getApiURL() async {
    try {
      final remoteConfig = await _getRemoteConfig();
      final url = remoteConfig.getString("api_base_url");
      return url;
    } on Exception {
      return "https://sttdyhnbqk.execute-api.ap-southeast-2.amazonaws.com/v1/";
    }
  }

  Future<bool> allowBuy() async {
    try {
      final remoteConfig = await _getRemoteConfig();
      final url = remoteConfig.getBool("allow_buy");
      return url;
    } on Exception {
      return false;
    }
  }
}
