import 'dart:io';

import '../commands/commands.dart' as cmd;
import '../project/project_pubspec.dart';
import '../templates/templates.dart';
import '../utils.dart';

/// List of base packages that any project should have.
const basePackages = [
  'go_router', // think about replacing with auto_route
  'equatable',
  // riverpod packages
  'hooks_riverpod',
  'riverpod_annotation',
  'dev:riverpod_generator',
  'dev:riverpod_lint',

  'flutter_hooks',
  'json_annotation',
  'intl:any',
  'dev:build_runner',
  'dev:json_serializable',
  'dev:custom_lint',
  'dev:very_good_analysis',
  'dev:mocktail',
];

/// List of flutter sdk related packages that any project should have.
const baseFlutterPackages = [
  'flutter_localizations',
];

/// Sets up the project packages.
/// Makes changes to the default project files created by `flutter create`
/// to setup the packages from `basePackages`.
///
/// The [workingDirPath] is the path to the project directory.
void setupPackages(String workingDirPath) {
  printMessage('Setting up packages');
  _addPackages(
    workingDirPath,
    packages: basePackages,
    flutterPackages: baseFlutterPackages,
  );
  final packages = [...basePackages, ...baseFlutterPackages];

  bool containsPackage(String packageName) {
    return packages.any((element) => element.contains(packageName));
  }

  if (containsPackage('very_good_analysis')) {
    _setupVeryGoodAnalysis(workingDirPath);
  }

  if (containsPackage('flutter_localizations')) {
    _setupLocalizations(workingDirPath);
  }
}

/// Adds the base packages to the project.
///
/// The [workingDirPath] is the path to the project directory.
///
/// The [packages] is a list of dart/flutter packages to add from [pub.dev](https://pub.dev).
void _addPackages(
  String workingDirPath, {
  required List<String> packages,
  required List<String> flutterPackages,
}) {
  printMessage('Adding base packages');
  cmd.pubAdd(packages, workingDirectory: workingDirPath);
  cmd.pubAdd(flutterPackages, workingDirectory: workingDirPath, sdk: 'flutter');
}

void _setupVeryGoodAnalysis(String workingDirPath) {
  printMessage('Setting up analysis_options...');
  final analysisOptionsPath = '$workingDirPath/analysis_options.yaml';
  File(analysisOptionsPath).writeAsStringSync(createAnalysisOptions());
}

void _setupLocalizations(String projectDirPath) {
  printMessage('Setting up localizations...');

  // enable `generate: true` in pubspec.yaml
  savePubspecToFile(
    pubspecEditor..update(['flutter', 'generate'], true),
  );

  // create l10n.yaml
  final l10nYamlPath = '$projectDirPath/l10n.yaml';
  final l10nYamlFile = File(l10nYamlPath);
  if (!l10nYamlFile.existsSync()) {
    l10nYamlFile.writeAsStringSync(createL10nYaml());
  } else {
    _showFileExistsMessage(l10nYamlFile);
  }

  // create lib/l10n directory
  final arbDirPath = '$projectDirPath/lib/l10n';
  final arbDir = Directory(arbDirPath);
  if (!arbDir.existsSync()) {
    arbDir.createSync(recursive: true);
  }

  // create lib/l10n/app_localizations.dart
  // with extension for easy access to l10n
  final localizationsPath = '$projectDirPath/lib/l10n/l10n.dart';
  final localizationsFile = File(localizationsPath);
  if (!localizationsFile.existsSync()) {
    localizationsFile.writeAsStringSync(createL10nDart());
  } else {
    _showFileExistsMessage(localizationsFile);
  }

  // create lib/l10n/app_en.arb
  final arbFile = File('$arbDirPath/app_en.arb');
  if (!arbFile.existsSync()) {
    arbFile.writeAsStringSync(createInitialArb());
  } else {
    _showFileExistsMessage(arbFile);
  }
}

void _showFileExistsMessage(File file) {
  return printMessage(
    '${file.uri.pathSegments.last} already exists, '
    'skip generation to not override existing file.',
  );
}
