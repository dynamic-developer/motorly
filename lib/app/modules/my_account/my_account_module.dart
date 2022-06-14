import 'package:flutter_modular/flutter_modular.dart';
import '../home/cubits/sign_out/sign_out_cubit.dart';
import '../home/cubits/user/user_cubit.dart';

import 'cubit/edit_user/edit_user_cubit.dart';
import 'pages/my_account_page.dart';
import 'pages/profile_page.dart';

class MyAccountModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => SignOutCubit(i())),
        Bind((i) => EditUserCubit(i())),
        Bind((i) => UserCubit(i())),
      ];

  @override
  List<ChildRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => ProfilePage()),
        ChildRoute("/details", child: (_, args) => MyAccountPage()),
      ];
}
