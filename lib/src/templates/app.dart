String createAppDart() {
  return '''
import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/theme.dart';
import 'routing/routing.dart';

export 'routing/routing.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App', // TODO(dev): Change the title
      theme: createLightTheme(),
      darkTheme: createDarkTheme(),
      routerConfig: appRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
''';
}
