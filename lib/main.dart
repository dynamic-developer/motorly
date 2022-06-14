import 'flavors/flavor_config.dart';
import 'flavors/prod_values.dart';
import 'main_common.dart';

void main() async {
  FlavorConfig(flavor: Flavors.PROD, values: ProdValues());
  await mainCommon();
}
