import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/repositories/database_repository.dart';
import '../home/cubits/filter/filter.cubit.dart';
import '../home/cubits/loader/loader.cubut.dart';
import '../home/cubits/navigation/navigation.cubit.dart';
import '../home/cubits/plate_by_image/plate_by_image_cubit.dart';
import '../home/cubits/select_image/select_image_cubit.dart';
import 'cubits/recent_models/recent_models_cubit.dart';
import 'cubits/recent_offers/recent_offers_cubit.dart';
import 'dashboard_page.dart';
import 'pages/recent_motors_page.dart';

class DashboardModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => RecentOffersCubit(i.get<DatabaseRepository>())),
        Bind((i) => RecentModelsCubit(i.get<DatabaseRepository>())),
        Bind((i) => SelectImageCubit(i())),
        Bind((i) => PlateByImageCubit(i())),
        Bind((i) => NavigationCubit()),
        Bind((i) => FilterCubit()),
        Bind((i) => LoaderCubit()),
      ];

  @override
  List<ChildRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => DashboardPage()),
        ChildRoute(
          "/recent-motors",
          child: (context, args) => RecentMotorsPage(args.data),
        )
      ];
}
