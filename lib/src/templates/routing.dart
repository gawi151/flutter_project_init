String createRoutingDart() {
  return '''
import 'package:go_router/go_router.dart';

import 'home_route.dart';

export 'home_route.dart';

final appRouter = GoRouter(
  routes: [
    HomeRoute(),
  ],
);
''';
}
