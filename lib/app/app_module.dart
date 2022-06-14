import 'package:flutter_modular/flutter_modular.dart';

import 'modules/authentication/authentication_module.dart';
import 'modules/authentication/cubits/sign_in/sign_in_cubit.dart';
import 'modules/authentication/cubits/sign_up/sign_up_cubit.dart';
import 'modules/dashboard/dashboard_module.dart';
import 'modules/favorites/favorites_module.dart';
import 'modules/home/cubits/loader/loader.cubut.dart';
import 'modules/home/home_module.dart';
import 'modules/lessons/lessons_module.dart';
import 'modules/motor_details/motor_details_module.dart';
import 'modules/my_account/my_account_module.dart';
import 'modules/offers/offers_module.dart';
import 'modules/search/search_module.dart';
import 'modules/splash/cubits/authentication_state/authentication_state_cubit.dart';
import 'modules/splash/splash_module.dart';
import 'shared/api/api_client_factory.dart';
import 'shared/database/database_provider.dart';
import 'shared/repositories/database_repository.dart';
import 'shared/repositories/user_repository.dart';
import 'shared/services/dynamic_link_service.dart';
import 'shared/services/firestore_service.dart';
import 'shared/services/payment_service.dart';

class AppModule extends Module {
  List<Bind> get binds => [
        Bind((i) => ApiClientFactory.create()),
        Bind((i) => UserRepository()),
        Bind((i) => DatabaseProvider()),
        Bind((i) => DatabaseRepository(i())),
        Bind((i) => AuthenticationStateCubit(i())),
        Bind((i) => SignInCubit(i())),
        Bind((i) => SignUpCubit(i())),
        Bind((i) => FirestoreService()),
        Bind((i) => DynamicLinkService()),
        Bind((i) => InAppPurchaseService()),
        Bind((i) => LoaderCubit()),
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
        ModuleRoute("/search", module: SearchModule()),
        ModuleRoute("/favorites", module: FavoritesModule()),
        ModuleRoute(MotorDetailsModule.route, module: MotorDetailsModule()),
      ];
}
