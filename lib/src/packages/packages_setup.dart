import 'dart:io';

import 'package:code_builder/code_builder.dart';

import '../commands/commands.dart' as cmd;
import '../project/project_pubspec.dart';

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
  stdout.writeln('Adding base packages');
  cmd.pubAdd(packages, workingDirectory: workingDirPath);
  cmd.pubAdd(flutterPackages, workingDirectory: workingDirPath, sdk: 'flutter');
}

/// Sets up the project packages.
/// Makes changes to the default project files created by `flutter create`
/// to setup the packages from `basePackages`.
///
/// The [workingDirPath] is the path to the project directory.
void setupPackages(String workingDirPath) {
  stdout.writeln('Setting up packages...');
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

void _setupVeryGoodAnalysis(String workingDirPath) {
  stdout.writeln('Setting up very_good_analysis...');
  final analysisOptionsPath = '$workingDirPath/analysis_options.yaml';
  final analysisOptionsFile = File(analysisOptionsPath);
  if (!analysisOptionsFile.existsSync()) {
    analysisOptionsFile.createSync();
  }
  analysisOptionsFile.writeAsStringSync('''
include: package:very_good_analysis/analysis_options.yaml

linter:
  rules:
    always_use_package_imports: false
    avoid_relative_lib_imports: false
    prefer_relative_imports: true
    public_member_api_docs: false
  ''');
}


// done in lib/src/project/setup_project_structure.dart
//
// void _setupGoRouter(String workingDirPath) {
//   final appRouterPath = '$workingDirPath/lib/app/app_router.dart';
//   final appRouterFile = File(appRouterPath);
//   if (!appRouterFile.existsSync()) {
//     stdout.writeln('Setting up go_router...');
//     appRouterFile.createSync(recursive: true);

//     final appRouterDart = Library(
//       (b) => b.body.addAll([
//         Directive.import('package:go_router/go_router.dart'),
//         Field(
//           (b) => b
//             ..name = 'appRouter'
//             ..modifier = FieldModifier.final$
//             ..assignment = const Code('GoRouter(routes: [])'),
//         ),
//       ]),
//     );
//     final dartEmitter = DartEmitter(
//       orderDirectives: true,
//       useNullSafetySyntax: true,
//     );
//     appRouterFile.writeAsStringSync('${appRouterDart.accept(dartEmitter)}');

//   } else {
//     // we don't want to overwrite the file if it already exists
//   }
// }

void _setupLocalizations(String projectDirPath) {
  stdout.writeln('Setting up localizations...');

  // enable `generate: true` in pubspec.yaml
  savePubspecToFile(
    pubspecEditor
      ..update(
        ['flutter', 'generate'],
        true,
      ),
  );

  // create l10n.yaml
  final l10nYamlPath = '$projectDirPath/l10n.yaml';
  final l10nYamlFile = File(l10nYamlPath);
  if (!l10nYamlFile.existsSync()) {
    l10nYamlFile
      ..createSync()
      ..writeAsStringSync('''
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
''');
  }

  // create lib/l10n/app_localizations.dart
  // with extension for easy access to l10n
  final localizationsPath = '$projectDirPath/lib/l10n/l10n.dart';
  final localizationsFile = File(localizationsPath);
  if (!localizationsFile.existsSync()) {
    localizationsFile.createSync(recursive: true);
    final dartEmitter = DartEmitter(
      orderDirectives: true,
      useNullSafetySyntax: true,
    );
    final localizationsDart = Library(
      (b) => b.body.addAll([
        Directive.import('package:flutter/widgets.dart'),
        Directive.import(
          'package:flutter_gen/gen_l10n/app_localizations.dart',
        ),
        Directive.export(
          'package:flutter_gen/gen_l10n/app_localizations.dart',
        ),
        Extension(
          (b) => b
            ..name = 'AppLocalizationsX'
            ..on = refer('BuildContext')
            ..methods.add(
              Method(
                (b) => b
                  ..name = 'l10n'
                  ..type = MethodType.getter
                  ..returns = refer('AppLocalizations')
                  ..body = refer('AppLocalizations')
                      .property('of')
                      .call([refer('this')])
                      .nullChecked
                      .code,
              ),
            ),
        ),
      ]),
    );
    localizationsFile
        .writeAsStringSync('${localizationsDart.accept(dartEmitter)}');
  }

  // create lib/l10n directory
  final arbDirPath = '$projectDirPath/lib/l10n';
  final arbDir = Directory(arbDirPath);
  if (!arbDir.existsSync()) {
    arbDir.createSync(recursive: true);
  }

  // create lib/l10n/app_en.arb
  final arbFile = File('$arbDirPath/app_en.arb');
  if (!arbFile.existsSync()) {
    arbFile
      ..createSync()
      ..writeAsStringSync('''
{
  "@@locale": "en",
  "appName": "Name of the app"
}
''');
  }
}
