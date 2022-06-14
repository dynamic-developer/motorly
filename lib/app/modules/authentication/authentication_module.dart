import 'package:flutter_modular/flutter_modular.dart';

import 'authentication_page.dart';
import 'cubits/reset_password/reset_password_cubit.dart';
import 'cubits/sign_in/sign_in_cubit.dart';
import 'cubits/sign_up/sign_up_cubit.dart';
import 'pages/finish_reset/finish_reset_page.dart';
import 'pages/reset_password/reset_password_page.dart';
import 'pages/sign_up/sign_up_page.dart';

class AuthenticationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => SignInCubit(i())),
        Bind((i) => SignUpCubit(i())),
        Bind((i) => ResetPasswordCubit(i())),
      ];

  @override
  List<ChildRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => AuthenticationPage(),
        ),
        ChildRoute(
          "/sign-up",
          child: (_, args) => SignUpPage(),
        ),
        ChildRoute(
          "/reset-password",
          child: (_, args) => ResetPasswordPage(),
        ),
        ChildRoute(
          "/reset-finish",
          child: (_, args) => FinishResetPage(),
        ),
      ];
}
