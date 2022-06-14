import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/app_module.dart';

void main() {
  Modular.init(AppModule());

  // setUp(() {
  //     bloc = AuthenticationModule.to.get<AuthenticationBloc>();
  // });

  // group('AuthenticationBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<AuthenticationBloc>());
  //   });
  // });
}
