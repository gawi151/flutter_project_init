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

import '../templates/templates.dart';
import 'project_paths.dart';

/// Prepares directories and initial files:
/// - create default structure of directories
/// - create default files related to the app
/// - TODO(gawi151): create dirs and files for installed packages based on setup
void setupProjectStructure({required String workingDirectory}) {
  _setupTheme(workingDirectory);
  _setupRouting(workingDirectory);
  _setupAppWidget(workingDirectory);
  // last because it depends on many previous 
  // steps (theme, routing, package setup, etc.)
  _setupMainDart(workingDirectory);
}

void _setupAppWidget(String workingDirPath) {
  final appDir = Directory('${libDir.path}/app')..createSync(recursive: true);
  File('${appDir.path}/app.dart').writeAsStringSync(createAppDart());
}

void _setupRouting(String workingDirPath) {
  final appDir = Directory('${libDir.path}/app');
  final pageDir = Directory('${appDir.path}/page');
  final homePageDir = Directory('${pageDir.path}/home')
    ..createSync(recursive: true);
  final routingDir = Directory('${appDir.path}/routing')
    ..createSync(recursive: true);

  File('${homePageDir.path}/home.dart').writeAsStringSync(createHomeDart());

  File('${routingDir.path}/home_route.dart')
      .writeAsStringSync(createHomeRoute());

  File('${routingDir.path}/routing.dart')
      .writeAsStringSync(createRoutingDart());
}

void _setupTheme(String workingDirPath) {
  final themeDir = Directory('${libDir.path}/theme')
    ..createSync(recursive: true);
  File('${themeDir.path}/colors.dart').writeAsStringSync(createColorsDart());
  File('${themeDir.path}/theme.dart').writeAsStringSync(createThemeDart());
}

void _setupMainDart(String workingDirPath) {
  mainDartFile.writeAsStringSync(createMainDart());
}
