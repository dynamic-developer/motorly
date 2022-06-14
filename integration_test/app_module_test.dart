import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/modules/authentication/authentication_module.dart';
import 'package:motorly/app/modules/dashboard/dashboard_module.dart';
import 'package:motorly/app/modules/favorites/favorites_module.dart';
import 'package:motorly/app/modules/home/home_module.dart';
import 'package:motorly/app/modules/lessons/lessons_module.dart';
import 'package:motorly/app/modules/my_account/my_account_module.dart';
import 'package:motorly/app/modules/offers/offers_module.dart';
import 'package:motorly/app/modules/splash/cubits/authentication_state/authentication_state_cubit.dart';
import 'package:motorly/app/modules/splash/splash_module.dart';
import 'package:motorly/app/shared/api/api_client_factory.dart';
import 'package:motorly/app/shared/database/database_provider.dart';
import 'package:motorly/app/shared/repositories/database_repository.dart';
import 'package:motorly/app/shared/repositories/user_repository.dart';
import 'package:motorly/app/shared/services/firestore_service.dart';

class AppModuleTest extends Module {
  List<Bind> get binds => [
        Bind((i) => ApiClientFactory.create()),
        Bind((i) => UserRepository()),
        Bind((i) => DatabaseProvider()),
        Bind((i) => DatabaseRepository(i())),
        Bind((i) => AuthenticationStateCubit(i())),
        Bind((i) => FirestoreService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Modular.initialRoute, module: SplashModule()),
        ModuleRoute("/dashboard", module: DashboardModule()),
        ModuleRoute("/authentication", module: AuthenticationModule()),
        ModuleRoute("/home", module: HomeModule()),
        ModuleRoute("/tutorial", module: LessonsModule()),
        ModuleRoute("/my-account", module: MyAccountModule()),
        ModuleRoute("/offers", module: OffersModule()),
        ModuleRoute("/favorites", module: FavoritesModule()),
      ];
}
