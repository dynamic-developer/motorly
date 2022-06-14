import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/modules/home/cubits/loader/loader.cubut.dart';

import '../../shared/services/firestore_service.dart';
import '../dashboard/cubits/favorites/check_favorite_cubit.dart';
import 'offers_page.dart';
import 'pages/offer_details_page.dart';

class OffersModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => CheckFavoritesCubit(i.get<FirestoreService>())),
        Bind((i) => LoaderCubit()),
      ];

  @override
  List<ChildRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => OffersPage(args: args.data),
        ),
        ChildRoute(
          "/details",
          child: (context, args) => OfferDetailsPage(offer: args.data),
        )
      ];
}
