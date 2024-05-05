import 'dart:io';

import 'package:yaml_edit/yaml_edit.dart';

import 'project.dart';

String? _pubspecRawContent;

/// Returns the [YamlEditor] for the pubspec.yaml file.
YamlEditor get pubspecEditor {
  if (_pubspecRawContent != null) {
    return YamlEditor(_pubspecRawContent!);
  }
  final pubspecFile = File('$projectDirectoryPath/pubspec.yaml');
  _pubspecRawContent = pubspecFile.readAsStringSync();
  return YamlEditor(_pubspecRawContent!);
}

/// Saves the [pubspec] editor to the pubspec.yaml file.
///
/// Overwrites the file.
void savePubspecToFile(YamlEditor pubspec) {
  final pubspecFile = File('$projectDirectoryPath/pubspec.yaml');
  final pubspecContent = pubspec.toString();
  pubspecFile.writeAsStringSync(pubspecContent);
  _pubspecRawContent = pubspecContent;
}
