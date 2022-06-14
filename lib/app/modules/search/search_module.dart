import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/services/firestore_service.dart';
import '../dashboard/cubits/favorites/check_favorite_cubit.dart';
import '../offers/pages/offer_details_page.dart';
import 'cubits/search/search_cubit.dart';
import 'repository/search_repository.dart';
import 'search_page.dart';

class SearchModule extends Module {
  static String get route => "/search";

  @override
  List<Bind> get binds => [
        Bind((i) => CheckFavoritesCubit(i.get<FirestoreService>())),
        Bind((i) => SearchRepository(i())),
        Bind((i) => SearchCubit(i())),
      ];

  @override
  List<ChildRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => SearchPage(args: args.data),
        ),
        ChildRoute(
          "/details",
          child: (context, args) => OfferDetailsPage(offer: args.data),
        )
      ];
}
