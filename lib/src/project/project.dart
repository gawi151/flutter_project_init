// utils

import 'dart:io';

import '../commands/commands.dart' as cmd;
import '../utils.dart';

export 'setup_project_structure.dart';

late String _projectDirectoryPath;

/// The path to the project directory.
String get projectDirectoryPath => _projectDirectoryPath;

/// The project directory.
Directory get projectDirectory => Directory(_projectDirectoryPath);

/// Initializes the empty project template by
/// removing not needed packages and initializing git.
void initProjectTemplate(List<String> args) {
  _setupWorkingDir(args);
  _cleanupTemplatePackages();
  cmd.gitInit();
}

void _setupWorkingDir(List<String> args) {
  if (args.isEmpty || args[0].isEmpty) {
    printError('Please provide a project directory');
    exit(-1);
  }
  final projectDir = Directory(args[0]);
  if (!projectDir.existsSync()) {
    printError('Project directory does not exist');
    exit(-1);
  }
  _projectDirectoryPath = projectDir.absolute.path;
  debugPrint('workingDirPath: $_projectDirectoryPath');
}

void _cleanupTemplatePackages() {
  printMessage('Removing not needed packages from app template...');
  final packagesToRemove = ['flutter_lints'];
  cmd.pubRemove(packagesToRemove, workingDirectory: _projectDirectoryPath);
}
