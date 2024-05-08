String createHomeRoute() {
  return '''
import 'package:go_router/go_router.dart';

import '../page/home/home.dart';

class HomeRoute extends GoRoute {
  HomeRoute()
      : super(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
          routes: [
            // TODO(dev): Add more routes here
          ],
        );
}
''';
}
