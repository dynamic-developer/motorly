import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/modules/home/cubits/filter/filter.cubit.dart';

import '../../shared/repositories/database_repository.dart';
import '../../shared/services/firestore_service.dart';
import '../dashboard/cubits/favorites/check_favorite_cubit.dart';
import '../dashboard/cubits/favorites/favorites_cubit.dart';
import '../dashboard/cubits/recent_models/recent_models_cubit.dart';
import '../dashboard/cubits/recent_offers/recent_offers_cubit.dart';
import '../favorites/cubits/motors_favorite/check_motor_favorite_cubit.dart';
import '../favorites/cubits/motors_favorite/motor_favorites_cubit.dart';
import '../search/cubits/search/search_cubit.dart';
import '../search/repository/search_repository.dart';
import 'cubits/navigation/navigation.cubit.dart';
import 'cubits/plate_by_image/plate_by_image_cubit.dart';
import 'cubits/select_image/select_image_cubit.dart';
import 'cubits/sign_out/sign_out_cubit.dart';
import 'cubits/user/user_cubit.dart';
import 'home_page.dart';
import 'pages/camera_instructions_page.dart';
import 'pages/market_page.dart';
import 'pages/reinsert_plate_page.dart';
import 'repositories/plate_image_repository.dart';
import 'services/select_image_service.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => FilterCubit()),
        Bind((i) => NavigationCubit()),
        Bind((i) => SignOutCubit(i())),
        Bind((i) => SelectImageService()),
        Bind((i) => PlateImageRepository()),
        Bind((i) => SelectImageCubit(i())),
        Bind((i) => PlateByImageCubit(i())),
        Bind((i) => UserCubit(i())),
        Bind((i) => FavoritesCubit(i.get<FirestoreService>())),
        Bind((i) => RecentOffersCubit(i.get<DatabaseRepository>())),
        Bind((i) => RecentModelsCubit(i.get<DatabaseRepository>())),
        Bind((i) => CheckFavoritesCubit(i.get<FirestoreService>())),
        Bind((i) => MotorsFavoritesCubit(i.get<FirestoreService>())),
        Bind((i) => CheckMotorFavoritesCubit(i.get<FirestoreService>())),
        Bind((i) => CheckFavoritesCubit(i())),
        Bind((i) => CheckMotorFavoritesCubit(i.get<FirestoreService>())),
        Bind((i) => SearchRepository(i())),
        Bind((i) => SearchCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
        ChildRoute(
          "/reinsert-plate",
          child: (_, args) => ReinsertPlatePage(
            imageByteArray: args.data,
          ),
        ),
        ChildRoute(
          "/camera-instructions",
          child: (_, args) => CameraInstructionsPage(),
        ),
        ChildRoute(
          "/market-page",
          child: (_, args) => MarketPage(),
        ),
      ];
}
