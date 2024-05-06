// Creates the project structure inside the project directory.
//
// This function creates the following folders and files:
//
// - 'lib/env' folder
// - 'lib/env/env.dart' file
// - 'assets' folder
// - 'assets/images' folder
// - 'assets/images/.gitkeep' file
// - 'assets/fonts' folder
// - 'assets/fonts/.gitkeep' file
// - 'assets/icons' folder
// - 'assets/icons/.gitkeep' file
// WIP

import 'dart:io';

import 'project_paths.dart';

void setupProjectStructure({required String workingDirectory}) {
  // TODO(gawi151): move package related code here.
  // TODO(gawi151): consider using a template file or use code builder.
  _setupTheme(workingDirectory);
  _setupRouting(workingDirectory);
  _setupAppWidget(workingDirectory);
  _setupMainDart(workingDirectory);
}

void _setupAppWidget(String workingDirPath) {
  final appDir = Directory('${libDir.path}/app')..createSync(recursive: true);
  File('${appDir.path}/app.dart').writeAsStringSync('''
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
''');
}

void _setupRouting(String workingDirPath) {
  final appDir = Directory('${libDir.path}/app');
  final pageDir = Directory('${appDir.path}/page');
  final homePageDir = Directory('${pageDir.path}/home')
    ..createSync(recursive: true);
  final routingDir = Directory('${appDir.path}/routing')
    ..createSync(recursive: true);

  File('${homePageDir.path}/home.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Text('You should update this page to show something useful.'),
    );
  }
}
''');

  File('${routingDir.path}/home_route.dart').writeAsStringSync('''
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
''');

  File('${routingDir.path}/routing.dart').writeAsStringSync('''
import 'package:go_router/go_router.dart';

import 'home_route.dart';

export 'home_route.dart';

final appRouter = GoRouter(
  routes: [
    HomeRoute(),
  ],
);
''');
}

void _setupTheme(String workingDirPath) {
  final themeDir = Directory('${libDir.path}/theme')
    ..createSync(recursive: true);

  File('${themeDir.path}/colors.dart').writeAsStringSync(r'''
import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    this.white = Colors.white,
    this.black = Colors.black,
  });

  // add your custom colors here and
  // update the constructor, copyWith and lerp methods
  final Color? white;
  final Color? black;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? white,
    Color? black,
  }) {
    return AppColors(
      white: white ?? this.white,
      black: black ?? this.black,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      white: Color.lerp(white, other.white, t),
      black: Color.lerp(black, other.black, t),
    );
  }

  @override
  String toString() => 'AppColors(white: $white, black: $black)';
}

extension AppColorsContextX on BuildContext {
  /// Shortcut to access [AppColors] from [BuildContext]
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
''');

  File('${themeDir.path}/theme.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

export 'colors.dart';

ThemeData createLightTheme() {
  // TODO(dev): Implement the light theme
  return ThemeData.from(colorScheme: const ColorScheme.light());
}

ThemeData createDarkTheme() {
  // TODO(dev): Implement the dark theme
  return ThemeData.from(colorScheme: const ColorScheme.dark());
}
''');
}

void _setupMainDart(String workingDirPath) {
  mainDartFile.writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app/app.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}
''');
}
