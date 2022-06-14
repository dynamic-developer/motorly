import 'package:flutter_modular/flutter_modular.dart';

import 'lessons_page.dart';

class LessonsModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ChildRoute> get routes => [
        ChildRoute(Modular.initialRoute, child: (_, args) => TutorialPage()),
      ];
}
