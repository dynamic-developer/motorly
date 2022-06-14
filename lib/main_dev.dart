import 'flavors/dev_values.dart';
import 'flavors/flavor_config.dart';
import 'main_common.dart';

void main() async {
  FlavorConfig(flavor: Flavors.DEV, values: DevValues());
  await mainCommon();
}
