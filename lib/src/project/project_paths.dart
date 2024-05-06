import 'dart:io';

import 'project.dart';

export 'project.dart' show projectDirectory, projectDirectoryPath;

/// The path to `lib` directory.
final libDir = Directory('${projectDirectory.path}/lib');

/// Project's pubspec file.
final pubspecFile = File('${projectDirectory.path}/pubspec.yaml');

/// The path to `lib/main.dart` file. Entry point of the project.
final mainDartFile = File('${libDir.path}/main.dart');
