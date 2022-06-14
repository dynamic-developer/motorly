import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/services/firestore_service.dart';
import '../dashboard/cubits/favorites/check_favorite_cubit.dart';
import '../dashboard/cubits/favorites/favorites_cubit.dart';
import 'cubits/motors_favorite/check_motor_favorite_cubit.dart';
import 'cubits/motors_favorite/motor_favorites_cubit.dart';
import 'pages/favorites_details_page.dart';
import 'wishlist_page.dart';

class FavoritesModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => FavoritesCubit(i.get<FirestoreService>())),
        Bind((i) => CheckFavoritesCubit(i.get<FirestoreService>())),
        Bind((i) => MotorsFavoritesCubit(i.get<FirestoreService>())),
        Bind((i) => CheckMotorFavoritesCubit(i.get<FirestoreService>())),
      ];

  @override
  List<ChildRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => WishlistPage(),
        ),
        ChildRoute(
          "/details",
          child: (context, args) => FavoritesDetailedPage(offer: args.data),
        )
      ];
}
