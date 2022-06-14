import 'package:flutter_modular/flutter_modular.dart';
import 'package:motorly/app/app_module.dart';

void main() {
  Modular.init(AppModule());

  // setUp(() {
  //     bloc = SplashModule.to.get<SplashBloc>();
  // });

  // group('SplashBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<SplashBloc>());
  //   });
  // });
}
